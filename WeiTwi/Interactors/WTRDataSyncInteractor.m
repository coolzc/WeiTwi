//
//  WTRDataSyncInteractor.m
//  WeiTwi
//
//  Created by zhangcheng on 10/13/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRDataSyncInteractor.h"

@interface WTRDataSyncInteractor ()

@property (nonatomic, strong) NSDate *queryDate;

@end

@implementation WTRDataSyncInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)syncDataAfterTimestamp:(NSNumber *)timestamp {
    if (timestamp) {
        self.queryDate = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];
    }
    [self startSyncData];
}

#pragma mark - Private Methods

- (void)startSyncData {
    if ([self.delegate respondsToSelector:@selector(dataSyncInteractorDidStartSync:)]) {
        [self.delegate dataSyncInteractorDidStartSync:self];
    }
    [self fetchArticlesAtPage:1];
}

- (void)finishSyncData {
    if ([self.delegate respondsToSelector:@selector(dataSyncInteractorDidFinishSync:)]) {
        [self.delegate dataSyncInteractorDidFinishSync:self];
    }
}

- (void)fetchArticlesAtPage:(NSInteger)pageNumber {
//    CFPagination *pagination = [CFPagination paginationOfSize:100 pageNumber:pageNumber];
//    CFApiRequest *request = [CFApiRequest requestForArticlesAfterDate:self.queryDate pagination:pagination];
//    request.extraInfo = pagination;
//    [self.apiService sendRequest:request];
    [self finishSyncData];
}

@end
