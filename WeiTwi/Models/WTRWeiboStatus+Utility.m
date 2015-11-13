//
//  WTRWeiboStatus+Utility.m
//  WeiTwi
//
//  Created by zhangcheng on 10/31/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboStatus+Utility.h"
#import "WTRWeiboGeo+Utility.h"
#import "WTRWeiboUser+Utility.h"

@implementation WTRWeiboStatus (Utility)

-(void)updateWeiboStatusInfo:(WTRWeiboStatusInfo *)statusInfo {
    self.createdAt = statusInfo.createdAt;
    self.statusId = statusInfo.statusId;
    self.statusMid = statusInfo.statusMid;
    self.idStr = statusInfo.idStr;
    self.text = statusInfo.text;
    self.source = statusInfo.source;
    self.favorited = statusInfo.favorited;
    self.truncated = statusInfo.truncated;
    self.thumbnailPic = statusInfo.thumbnailPic;
    self.bmiddlePic = statusInfo.bmiddlePic;
    self.originalPic = statusInfo.originalPic;
    [self.geo updateWeiboGeoInfo:statusInfo.geo];
    [self.user updateWithUserInfo:statusInfo.user];
    //TODO:wether there is a conflict between these realization
    [self.retweetedStatus updateWeiboStatusInfo:statusInfo.retweetedStatus];
    self.repostsCount = statusInfo.repostsCount;
    self.commentsCount = statusInfo.commentsCount;
    self.attitudesCount = statusInfo.attitudesCount;
    self.visible = statusInfo.visible;
    //TODO  type not sure

    self.picUrls = statusInfo.picUrls;
    self.weiboAd = statusInfo.weiboAd;
}

@end
