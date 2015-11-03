//
//  WTRWeiboGeo+Utility.m
//  WeiTwi
//
//  Created by zhangcheng on 11/2/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import "WTRWeiboGeo+Utility.h"

@implementation WTRWeiboGeo (Utility)

- (void)updateWeiboGeoInfo:(WTRWeiboGeoInfo *)geoInfo {
    self.longitude = geoInfo.longitude;
    self.latitude = geoInfo.latitude;
    self.city = geoInfo.city;
    self.province = geoInfo.province;
    self.cityName = geoInfo.cityName;
    self.provinceName = geoInfo.provinceName;
    self.address = geoInfo.address;
    self.pinyin = geoInfo.pinyin;
    self.more = geoInfo.more;
}

@end
