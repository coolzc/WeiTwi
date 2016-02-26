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
#import "NSLayoutConstraint+Debugging.h"
#import "UINib+WeiTwi.h"
#import "WTRStatusPhotosCollectionViewCell.h"


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

@property (nonatomic, strong)NSArray *photoUrls;

@end

@implementation WTRTimelineCell

- (void)awakeFromNib {
    // Initialization code
    [self configureView];
    [self configureProperties];
}

- (void)photosCollectionViewDelegate:(id<UICollectionViewDelegate, UICollectionViewDataSource>)delegate {
    self.photosCollectionView.delegate = delegate;
    self.photosCollectionView.dataSource = delegate;
    [self.photosCollectionView reloadData];
}

- (void)removePhotosCollectionView {
    self.photosCollectionHeightConstraint.constant = 0.f;
    self.photosCollectionView.hidden = YES;
}

- (void)displayPhotosCollectionView {
    self.photosCollectionHeightConstraint.constant = 126.f;
    self.photosCollectionView.hidden = NO;
}


- (void)updateCellStatuses:(WTRWeiboStatusInfo *)statusesInfo {
    //status related profile
    self.nameLabel.text = statusesInfo.user.name;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:statusesInfo.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"tab_item_message_selected"]];
    self.producedTimeLabel.text = [NSDateFormatter weiboDateConvertToCustomFormat:statusesInfo.createdAt];
    self.sourceLabel.text = [statusesInfo.source sourceDataProcess:statusesInfo.source];
    //text and retweet
    [self displayWeiboStatusTextAndRetweetText:statusesInfo];
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
        self.retweetTextLabel.hidden = NO;
        NSString *userName = [@"@" stringByAppendingFormat:@"%@\n", statusesInfo.retweetedStatus.user.name];
        self.retweetTextLabel.text = [userName stringByAppendingString: statusesInfo.retweetedStatus.text];
//        [self.subStatusTextLabel highLightTextWithRedColor:NSMakeRange(0, [userName length])];
    } else {
        self.retweetTextLabel.hidden = YES;
        self.retweetTextLabel.text = @"";
    }
    
    NSRegularExpression *nameRegExp = AuthorNameRegularExpression();
    NSRegularExpression *linkRegExp = webLinkRegularExpression();
    NSRegularExpression *topicRegExp = topicRegularExpression();
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
                                  [self.retweetTextLabel addLinkToURL:url withRange:result.range];
                          }];
    }
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
    [self.photosCollectionView registerNib:[UINib nibForStatusPhotoCell] forCellWithReuseIdentifier:StatusPhotoCellReuseIdentifier];
}

- (void)configureProperties {
    self.photoUrls = @[];
}

@end
