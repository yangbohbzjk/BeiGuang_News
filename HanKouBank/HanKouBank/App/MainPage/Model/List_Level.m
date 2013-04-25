//
//  List_Level.m
//  HanKouBank
//
//  Created by David on 13-4-25.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "List_Level.h"

@implementation List_Level

- (id)initLevelWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.summary = [dic objectForKey:@"summary"];
        self.topic = [dic objectForKey:@"topic"];
        self.thumbnail = [dic objectForKey:@"thumbnail"];
        self.docType = [dic objectForKey:@"docType"];
        self.docSource = [dic objectForKey:@"docSource"];
        self.docId = [dic objectForKey:@"docId"];
        self.createDate = [dic objectForKey:@"createDate"];
        self.groupedCategoryId = [dic objectForKey:@"groupedCategoryId"];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@",self.summary,self.topic,self.thumbnail];
}
@end
