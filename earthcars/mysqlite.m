//
//  mysqlite.m
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "mysqlite.h"

@implementation mysqlite
+(mysqlite *)sharedManager{
    static mysqlite *manager = nil;
    @synchronized(self){
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    }
    return manager;
}
-(id)init{
    if (self = [super init]) {
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dataPath = [filePath stringByAppendingPathComponent:@"mysqlite.sqlite"];
        NSLog(@"%@",dataPath);
        _database = [[FMDatabase alloc] initWithPath:dataPath];
        if ([_database open]) {
            [self creatTable];
        }else{
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}
-(void)creatTable{
    NSString *sql = @"create table if not exists appinfo(serial integer Primary Key Autoincrement,title Varchar(1024),pubDate Varchar(1024),image Varchar(1024),url Varchar(1024),cmtCount intger)";
    BOOL isSuccess = [_database executeUpdate:sql];
    if (!isSuccess) {
        NSLog(@"creatTable error :%@",_database.lastErrorMessage);
    }
    NSLog(@"存取成功");
}
-(void)insertModel:(myModel *)model{
    
    myModel *appmodel = model;
    //NSLog(@"%@",appmodel.title);
    NSString *sql = @"insert into appinfo(title,pubDate,image,url,cmtCount) values(?,?,?,?,?)";
    
    BOOL isSuccess = [_database executeUpdate:sql,appmodel.title,appmodel.pubDate,appmodel.image,appmodel.url,appmodel.cmtCount];
    
    if (!isSuccess) {
        NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
    NSLog(@"存取成功");
    //NSLog(@"+++++++++++++++%@",appmodel.filename);
}
-(NSArray *)findModel{
    NSString *sql = @"select title,pubDate,image,url,cmtCount from appinfo";
    FMResultSet *rs = [_database executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray array];
    
    while ([rs next]) {
        myModel *appModel = [[myModel alloc] init];
        appModel.title = [rs stringForColumn:@"title"];
        appModel.pubDate  = [rs stringForColumn:@"pubDate"];
        appModel.image  = [rs stringForColumn:@"image"];
        appModel.url = [rs stringForColumn:@"url"];
        appModel.cmtCount = @([rs intForColumn:@"cmtCount"]);
        [arr addObject:appModel];
    }
    
    return arr;
}
-(void)deleteModelForAppld:(NSString *)title{
    
    NSString *sql = @"delete from appinfo where title = ?";
    if (![_database executeUpdate:sql,title]) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
}
@end
