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

@interface DBLevel : NSObject
{
    FMDatabase *_database;
}

@property (nonatomic, strong) FMDatabase *database;

//复制数据库到沙盒路径并打开数据库
-(NSString *)CopyDatabase:(NSString *)dbName;
//插入数据
- (void)insertWithContentPage:(ContentLevel *)item;
-(void)insertWithContentPageItemArray:(NSDictionary *)itemArray;
@end
