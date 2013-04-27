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
        NSLog(@"复制成功");
        self.database = [FMDatabase databaseWithPath:writableDBPath];
        if (![self.database open]) {

        }else{
            NSLog(@"open db is success");
        }
    }

    return writableDBPath;
}

- (void)insertWithContentPage:(ContentLevel *)item
{
    self.database = [[FMDatabase alloc]init];
    NSLog(@"item.createDate:%@",item.createDate);
    NSString *sql = [NSString stringWithFormat:@"insert into \"main\".\"NewsContents\" ( \"discussNum\", \"type\", \"docId\", \"channelId\", \"docSource\", \"topic\", \"videoURL\", \"content\", \"createDate\", \"bigImageURL\", \"middleImageURL\", \"authors\") values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"];
    [self.database executeUpdate:sql,item.discussNum,item.type,item.docId,item.channelId,item.docSource,item.topic,item.videoURL,item.content,item.createDate,item.bigImageURL,item.middleImageURL,item.authors];
    NSLog(@"insert run");
}

-(void)insertWithContentPageItemArray:(NSArray *)itemArray
{
    [self.database beginTransaction];
  //  [self insertWithContentPage:itemArray];
    [self.database commit];
}
@end
