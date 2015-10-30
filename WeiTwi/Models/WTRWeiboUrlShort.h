//
//  WTRWeiboUrlShort.h
//  WeiTwi
//
//  Created by zhangcheng on 10/30/15.
//  Copyright © 2015 XYZ. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface WTRWeiboUrlShort : NSManagedObject

@property (nonatomic, retain) NSString *urlShort;
@property (nonatomic, retain) NSString *urlLong;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *result;

@end
