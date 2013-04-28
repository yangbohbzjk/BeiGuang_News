//
//  RegisterViewController.h
//  HanKouBank
//
//  Created by David on 13-4-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBLevel.h"

@interface RegisterViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, strong) UITextField *User_textField;
//数据库模型
@property (nonatomic, strong) DBLevel *db;

@end
