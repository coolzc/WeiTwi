//
//  WTRTwitterCell.m
//  BuddhaSaid
//
//  Created by zhangcheng on 7/1/15.
//  Copyright (c) 2015 XYZ. All rights reserved.
//

#import "WTRTimelineCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDateFormatter+WTRUtility.h"
#import "NSString+WTRUtility.h"
#import "UILabel+WTRUtility.h"

static inline NSRegularExpression* AuthorNameRegularExpression() {
    static NSRegularExpression *_nameRegularExpression = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nameRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"@[-_a-zA-Z0-9\u4E00-\u9FA5]+"options:kNilOptions error:nil];
    });
    
    return _nameRegularExpression;
}

static inline NSRegularExpression *webLinkRegularExpression() {
    static NSRegularExpression *_webLinkRegularExpression = nil;
    
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        _webLinkRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?" options:kNilOptions error:nil];
    });
    return _webLinkRegularExpression;
}

static inline NSRegularExpression *topicRegularExpression() {
    static NSRegularExpression *_topicRegularExpression = nil;
    
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        _topicRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"#[^@#]+?#" options:kNilOptions error:nil];
    });
    return _topicRegularExpression;
}

static inline NSRegularExpression *emotionRegularExpression() {
    static NSRegularExpression *_emotionRegularExpression = nil;
    
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        _emotionRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:nil];
    });
    return _emotionRegularExpression;
}

@interface WTRTimelineCell () <TTTAttributedLabelDelegate>

@property (nonatomic, assign) NSInteger picturesNum;
@property (nonatomic, strong) NSArray *imageViews;
@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, assign) CGFloat statusTextHeight;
@property (nonatomic, assign) CGFloat reTweetTextHeight;
@property (nonatomic, strong) NSArray *picturesConstraints;

@end

@implementation WTRTimelineCell

- (void)awakeFromNib {
    // Initialization code
    [self configureView];
    [self configureProperties];
}


- (void)updateConstraints {
    //text + retweettext + pictures height
//    self.cellDynamicContentPartHeightConstraint.constant = self.cellHeight;
    //text
    self.userContentTextLabelHeightContraint.constant = self.statusTextHeight;
    //retweet
    self.subStatusTextLabelHeightConstraint.constant = self.reTweetTextHeight;
    //pictures
    self.picturesViewHeightConstraint.constant = self.totalHeight - self.statusTextHeight - self.reTweetTextHeight;
    //kinds of numbers picutes arrange configure
    NSNumber *topConstraint = self.picturesConstraints[0];
    NSNumber *bottomConstraint = self.picturesConstraints[1];
    NSNumber *leftConstraint = self.picturesConstraints[2];
    NSNumber *rightConstraint = self.picturesConstraints[3];
    self.topHorizontalLineToTopConstraint.constant =  topConstraint.floatValue;
    self.bottomHorizontalLineToBottomConstraint.constant = bottomConstraint.floatValue;
    self.leftVerticalLineToLeftConstraint.constant = leftConstraint.floatValue;
    self.rightVerticalLineToRightConstraint.constant = rightConstraint.floatValue;
    
    [super updateConstraints];
}

- (void)updateCellStatuses:(WTRWeiboStatusInfo *)statusesInfo {
    //status related profile
    self.nameLabel.text = statusesInfo.user.name;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:statusesInfo.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"tab_item_message_selected"]];
    self.producedTimeLabel.text = [NSDateFormatter weiboDateConvertToCustomFormat:statusesInfo.createdAt];
    self.sourceLabel.text = [statusesInfo.source sourceDataProcess:statusesInfo.source];
    //text and retweet
    [self displayWeiboStatusTextAndRetweetText:statusesInfo];
    // pictures
    [self clearImageViewPictures];
    if ([statusesInfo.thumbnailPic isNotBlank]) {
       self.picturesNum = [statusesInfo.picUrls count];
       [self loadPicturesFromRemote:statusesInfo.picUrls];
    } else if(statusesInfo.retweetedStatus.thumbnailPic){
        //retweet pictures
        self.picturesNum = [statusesInfo.retweetedStatus.picUrls count];
        [self loadPicturesFromRemote:statusesInfo.retweetedStatus.picUrls];
    } else {
        self.picturesNum = 0;
    }
    //retweet count
    if (0  < statusesInfo.commentsCount) {
        self.commentCountLabel.hidden = NO;
        self.commentCountLabel.text = [NSString stringWithFormat:@"%ld",(long)statusesInfo.commentsCount];
    } else {
        self.commentCountLabel.hidden = YES;
    }
    //comment count
    if (0  < statusesInfo.repostsCount) {
        self.retweetCountLabel.hidden = NO;
        self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld",(long)statusesInfo.repostsCount];
    } else {
        self.retweetCountLabel.hidden = YES;
    }
}

- (void)displayWeiboStatusTextAndRetweetText:(WTRWeiboStatusInfo *)statusesInfo {
    //text
    self.contentTextLabel.text = statusesInfo.text;
    self.contentTextLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    self.contentTextLabel.delegate = self;
    //retweet
    if (statusesInfo.retweetedStatus) {
        self.subStatusTextLabel.hidden = NO;
        NSString *userName = [@"@" stringByAppendingFormat:@"%@\n", statusesInfo.retweetedStatus.user.name];
        self.subStatusTextLabel.text = [userName stringByAppendingString: statusesInfo.retweetedStatus.text];
//        [self.subStatusTextLabel highLightTextWithRedColor:NSMakeRange(0, [userName length])];
    } else {
        self.subStatusTextLabel.hidden = YES;
        self.subStatusTextLabel.text = @"";
    }
    
    NSRegularExpression *nameRegExp = AuthorNameRegularExpression();
    NSRegularExpression *linkRegExp = webLinkRegularExpression();
    NSRegularExpression *topicRegExp = topicRegularExpression();
    NSLog(@"微博text:%@,retext:%@", statusesInfo.text, statusesInfo.retweetedStatus.text);
    [self addLinkToText:statusesInfo withRegularExpression:nameRegExp];
    [self addLinkToText:statusesInfo withRegularExpression:linkRegExp];
    [self addLinkToText:statusesInfo withRegularExpression:topicRegExp];
}

- (void)addLinkToText:(WTRWeiboStatusInfo *)statusesInfo withRegularExpression:(NSRegularExpression *)regExp {
    [regExp enumerateMatchesInString:statusesInfo.text
                                 options:0
                                   range:NSMakeRange(0, [statusesInfo.text length])
                              usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                                  
                                  NSURL *url = [NSURL URLWithString:@"http://github.com/mattt/"];
                                  [self.contentTextLabel addLinkToURL:url withRange:result.range];
                              }];
    if (statusesInfo.retweetedStatus) {
        [regExp enumerateMatchesInString:statusesInfo.retweetedStatus.text
                                 options:0
                                   range:NSMakeRange(0, [statusesInfo.retweetedStatus.text length])
                              usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {

                                  NSURL *url = [NSURL URLWithString:@"http://github.com/mattt/"];
                                  [self.subStatusTextLabel addLinkToURL:url withRange:result.range];
                          }];
    }
}

- (void)updateCellHeightConstraintValues:(CGFloat)totalHeight statusTextHeightValue:(CGFloat)statusTextHeight reTweetTextHeightValue:(CGFloat)reTweetTextHeight picturesViewConstraintsValues:(NSArray *)viewConstraints {
    self.totalHeight = totalHeight;
    self.statusTextHeight = statusTextHeight;
    self.reTweetTextHeight = reTweetTextHeight;
    self.picturesConstraints = viewConstraints;
}

#pragma mark - Actions

- (IBAction)commentButtonTouchUpInside:(id)sender {
    
}

- (IBAction)retweetButtonTouchUpInside:(id)sender {
    
}

- (IBAction)detailButtonTouchUpInside:(id)sender {
    
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithURL:(NSURL *)url atPoint:(CGPoint)point {
    NSLog(@"tap the text url TTTAttributedLabelDelegate actions");
}
#pragma mark - Private Methods

- (void)configureView {
    self.contentTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //make user avatar view round
    self.userImageView.layer.cornerRadius = 20.f;
    self.userImageView.clipsToBounds = YES;
    self.retweetCountLabel.hidden = YES;
    self.commentCountLabel.hidden = YES;
    self.contentTextLabel.userInteractionEnabled = YES;

}

- (void)configureProperties {
    self.picturesNum = 0;
    self.imageViews = @[self.image1View, self.image2View, self.image3View, self.image4View, self.image5View, self.image6View,self.image7View, self.image8View, self.image9View];
    self.picturesConstraints = @[];
}

- (void)loadPicturesFromRemote:(NSArray *)picUrls {
    //imageView with image
    if (4 == self.picturesNum) {
        [self.imageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = obj;
            if (idx == 0 || idx == 1 || idx == 3 || idx == 4) {
                if (2 > idx) {
                    [imageView sd_setImageWithURL:[picUrls objectAtIndex:idx] placeholderImage:[UIImage imageNamed:@"tab_item_message_selected"]];
                } else {
                    [imageView sd_setImageWithURL:[picUrls objectAtIndex:idx - 1] placeholderImage:[UIImage imageNamed:@"tab_item_message_selected"]];
                }
                imageView.hidden = NO;
            } else {
                imageView.hidden = YES;
            }
        }];
    } else {
        [self.imageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = obj;
            if (idx < [picUrls count]) {
                [imageView sd_setImageWithURL:[picUrls objectAtIndex:idx] placeholderImage:[UIImage imageNamed:@"tab_item_message_selected"]];
                imageView.hidden = NO;
            } else {
                imageView.hidden = YES;
            }
        }];
    }
}

- (void)clearImageViewPictures {
    for (UIImageView *imageView in self.imageViews) {
        imageView.image = nil;
    }
}

@end
