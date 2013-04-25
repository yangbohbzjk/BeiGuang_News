//
//  NSString+DateToChanged.m
//  HanKouBank
//
//  Created by David on 13-4-25.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "NSString+DateToChanged.h"

@implementation NSString (DateToChanged)
- (NSString *)DateToChanged:(NSString *)str
{
    NSString *string = [NSString stringWithFormat:@"%@月%@日 %@:%@",[[[[str componentsSeparatedByString:@" "] objectAtIndex:0] componentsSeparatedByString:@"-"] objectAtIndex:1],[[[[str componentsSeparatedByString:@" "] objectAtIndex:0] componentsSeparatedByString:@"-"] objectAtIndex:2],[[[[str componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:0],[[[[str componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:1]];
    return string;
}
@end
