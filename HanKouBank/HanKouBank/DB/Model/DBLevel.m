//
//  DBLevel.m
//  HanKouBank
//
//  Created by David on 13-4-27.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "DBLevel.h"

@implementation DBLevel
@synthesize database = _database;

-(NSString *)CopyDatabase:(NSString *)dbName 
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [Paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbName];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:dbName];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            
        }
    }else{
        NSLog(@"复制成功:%@",writableDBPath);
        self.database = [FMDatabase databaseWithPath:writableDBPath];
        if (![self.database open]) {
            NSLog(@"打开数据库失败!from CopyDatabase");
        }else{
           
            
        }
    }

    return writableDBPath;
}

- (void)insertWithContentPage:(ContentLevel *)item
{
    NSString *sql = [NSString stringWithFormat:@"insert into \"main\".\"NewsContents\" ( \"discussNum\", \"type\", \"docId\", \"channelId\", \"docSource\", \"topic\", \"videoURL\", \"content\", \"createDate\", \"bigImageURL\", \"middleImageURL\", \"authors\") values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
    [self.database executeUpdate:sql,item.discussNum,item.type,item.docId,item.channelId,item.docSource,item.topic,item.videoURL,item.content,item.createDate,item.bigImageURL,item.middleImageURL,item.authors];
    NSLog(@"insert run");
}

//注册用户账号，把用户信息写入User表中     相同用户名可以提交但不能写入数据库中，需要提示用户修改
- (void)insertWithUserInfo:(NSString *)username AndPass:(NSString *)userpass AndEmail:(NSString *)email AndRealname:(NSString *)realname AndUid:(NSNumber *)uid
{
    NSString *sql = [NSString stringWithFormat:@"insert into \"main\".\"Users\" ( \"password\", \"username\", \"uid\" , \"email\", \"realname\") values ( ?, ?, ?, ?, ?)"];
    [self.database executeUpdate:sql,userpass,username,uid,email,realname];
    NSLog(@"开始校验用户名是否重复...");
}

//登陆账号，在数据库中查询用户注册信息是否存在，存在进入主页，不存在重新输入
//只查询username，主键是否一致 username是需要查询的值 textfield。text
- (BOOL)selectUserFromDB:(NSString *)username
{
    //查询语句
    NSString *selectSql = [NSString stringWithFormat:@"select * from \"main\".\"Users\" where username = \"%@\"",username];
   FMResultSet *set = [self.database executeQuery:selectSql];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    while ([set next]) {
        NSString *name = [set stringForColumn:@"username"];
        NSLog(@"name:%@",name);
        [array addObject:name];
    }
    if ([array count]>0) {
        //如果数据库有相同用户名，返回真
        NSLog(@"arrayyes:%@",array);
        return YES;
    }else
        return NO;
}

//登陆查询：账号密码查询是否匹配，进行登陆查询
- (BOOL)selectUserAndPassFromDB:(NSString *)username AndPassText:(NSString *)password
{
    //查询语句
    NSString *selectSql = [NSString stringWithFormat:@"select * from main.Users where username=\"%@\" and password=%d",username,[password intValue]];
    FMResultSet *set = [self.database executeQuery:selectSql];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array2 =[NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        NSString *name = [set stringForColumn:@"username"];
        NSLog(@"name:%@",name);
        [array addObject:name];
        
        NSString *pass = [set stringForColumn:@"password"];
        NSLog(@"password:%@",pass);
        [array2 addObject:pass];
    }
    
    if ([array count]>0 && [array2 count]>0) {
        //如果数据库有相同用户名，返回真
        NSLog(@"arrayyes:%@",array);
        return YES;
    }else
        return NO;
}


- (void)CloseDB
{
    [self.database close];
    NSLog(@"database is closed!");
}



@end
