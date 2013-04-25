//
//  List_Level.h
//  HanKouBank
//
//  Created by David on 13-4-25.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List_Level : NSObject

//List_Level数据模型

@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSNumber *docType;
@property (nonatomic, strong) NSString *docSource;
@property (nonatomic, strong) NSNumber *docId;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSNumber *groupedCategoryId;
- (id)initLevelWithDic:(NSDictionary *)dic;
@end
