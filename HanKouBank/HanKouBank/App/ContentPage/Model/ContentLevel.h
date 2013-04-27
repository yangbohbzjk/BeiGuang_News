//
//  ContentLevel.h
//  HanKouBank
//
//  Created by David on 13-4-26.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentLevel : NSObject

//内容页的数据模型
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, assign) NSNumber *docId;
@property (nonatomic, strong) NSString *middleImageURL;
@property (nonatomic, strong) NSString *bigImageURL;
@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) NSString *docSource;
@property (nonatomic, strong) NSDate   *createDate;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSNumber *discussNum;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSNumber *channelId;
@property (nonatomic, strong) NSString *authors;

- (id)initContentLevelWithDic:(NSDictionary *)dic;

@end
