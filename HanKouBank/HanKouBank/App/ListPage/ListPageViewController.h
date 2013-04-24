//
//  ListPageViewController.h
//  HanKouBank
//
//  Created by David on 13-4-24.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@interface ListPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>

@property (nonatomic, strong) UITableView *mTableView;
//@property (nonatomic, strong) 
@property (nonatomic, strong)NSMutableDictionary *listDict;
@end
