//
//  SomeMethod.h
//  HanKouBank
//
//  Created by David on 13-4-26.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SomeMethodDelegate <NSObject>

// hidden backBar and new a backBar + frame to self controller
- (void) HiddenBackBarWithNewYourBackBar;
//implement backPoPTo Super
- (void) BackBarPopToSuper;

@end
