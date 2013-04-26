//
//  NSString+DateToChanged.h
//  HanKouBank
//
//  Created by David on 13-4-25.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateToChanged)

//M月D日 H：M
- (NSString *)DateToChanged:(NSString *)str;
//Y年M月D日 H：M
- (NSString *)YearDateToChanged:(NSString *)str;
- (NSString *)TextFilterHTML:(NSString *)str;
@end
