//
//  Level.h
//  TestTestJson
//
//  Created by jianxin on 13-4-24.
//  Copyright (c) 2013年 jianxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject
@property (strong, nonatomic) NSNumber *Id;
@property (strong, nonatomic) NSNumber *sortFlag;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSNumber *channelType;
@property (strong, nonatomic) NSNumber *level;
@property (strong, nonatomic) NSString *channelIcon;
@property (strong, nonatomic) NSMutableArray *sons;
- (id)initLevelWithDic:(NSDictionary*)dic;
- (void)titleFromJson:(NSDictionary *)dic;
@end
