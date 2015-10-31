//
//  WTRWeiboGeoInfo.h
//  WeiTwi
//
//  Created by zhangcheng on 10/31/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRWeiboGeoInfo : NSObject

@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *pinyin;
@property (nonatomic, strong) NSString *more;

@end
