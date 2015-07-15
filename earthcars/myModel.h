//
//  myModel.h
//  earthcars
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *pubDate;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSNumber *cmtCount;
@property (nonatomic,copy)NSString *banner;
@property (nonatomic,copy)NSString *zbTime;
@property (nonatomic,copy)NSString *zbState;
@property (nonatomic,copy)NSString *titile;
@property (nonatomic,copy)NSString *bbsname;
@property (nonatomic,copy)NSString *smallimg;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSNumber* playcount;
@property (nonatomic,copy)NSString *shareaddress;
@property (nonatomic,copy)NSString *lastreplydate;
@property (nonatomic,copy)NSString *smallpic;
@property (nonatomic,copy)NSString *url43g;

@property (nonatomic,copy)NSString *keyword;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *sid;

@property (nonatomic,copy)NSString *priceRange;
@property (nonatomic,copy)NSNumber *topicid;
@property (nonatomic,copy)NSString *kind;
@property (nonatomic,copy)NSString *modelTotal;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *prices;
@property (nonatomic,copy)NSString *brandIntroduction;
@property (nonatomic,copy)NSString *currentCity;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *dayPictureUrl;
@property (nonatomic,copy)NSString *weather;
@property (nonatomic,copy)NSString *wind;
@property (nonatomic,copy)NSString *temperature;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)valueForUndefinedKey:(NSString *)key;
@end
