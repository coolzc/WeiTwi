//
//  WTRWeiboGeo.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface WTRWeiboGeo : NSManagedObject

@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *cityName;
@property (nonatomic, retain) NSString *provinceName;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *pinyin;
@property (nonatomic, retain) NSString *more;


@end
