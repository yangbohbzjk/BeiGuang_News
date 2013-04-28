//
//  DBLevel.h
//  HanKouBank
//
//  Created by David on 13-4-27.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ContentLevel.h"

@interface DBLevel : NSObject<UIAlertViewDelegate>
{
    FMDatabase *_database;
}

@property (nonatomic, strong) FMDatabase *database;

//复制数据库到沙盒路径并打开数据库
-(NSString *)CopyDatabase:(NSString *)dbName;
//关闭数据库
- (void)CloseDB;

//插入数据
- (BOOL)insertWithUserInfo:(NSString *)username AndPass:(NSString *)userpass AndEmail:(NSString *)email AndRealname:(NSString *)realname AndUid:(NSNumber *)uid;
- (void)insertWithContentPage:(ContentLevel *)item;

//查询用户名是否重复
- (BOOL)selectUserFromDB:(NSString *)username;

@end
