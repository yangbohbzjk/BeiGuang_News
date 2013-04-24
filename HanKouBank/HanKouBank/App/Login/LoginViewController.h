//
//  LoginViewController.h
//  HanKouBank
//
//  Created by David on 13-4-23.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "ASIFormDataRequest.h"
@interface LoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate>

@property (nonatomic, strong) UITableView *mTableView;


@end
