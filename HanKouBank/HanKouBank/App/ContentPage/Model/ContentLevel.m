//
//  ContentLevel.m
//  HanKouBank
//
//  Created by David on 13-4-26.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ContentLevel.h"

@implementation ContentLevel

- (id)initContentLevelWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.type = [dic objectForKey:@"type"];
        self.middleImageURL = [dic objectForKey:@"middleImageURL"];
        self.bigImageURL = [dic objectForKey:@"bigImageURL"];
        self.videoURL = [dic objectForKey:@"videoURL"];
        self.topic = [dic objectForKey:@"topic"];
        self.docSource = [dic objectForKey:@"docSource"];
        self.createDate = [dic objectForKey:@"createDate"];
        self.content = [dic objectForKey:@"content"];
        self.discussNum = [dic objectForKey:@"discussNum"];
        self.docId = [dic objectForKey:@"docId"];
        self.path = [dic objectForKey:@"path"];
        
        self.channelId = [dic objectForKey:@"channelId"];
        self.authors = [dic objectForKey:@"authors"];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@",self.topic,self.content,self.createDate];
}
@end
