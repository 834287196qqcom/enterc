//
//  mysqlite.h
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "myModel.h"
@interface mysqlite : NSObject
{
    FMDatabase *_database;
}


+(mysqlite *)sharedManager;

-(void)insertModel:(myModel *)model;
-(void)deleteModelForAppld:(NSString *)title;
-(NSArray *)findModel;

@end
