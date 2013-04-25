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
@interface ListPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *mTableView;
//@property (nonatomic, strong) 
@property (nonatomic, strong)NSMutableDictionary *listDict;

//sons传入
@property (nonatomic, weak) NSMutableArray *arr;
//sons中的text集合
@property (nonatomic, strong) NSMutableArray *strArray;
@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, strong) NSMutableArray *sortArray;

//button URL
@property (nonatomic, strong) NSString *button_url;
//button tag
@property (nonatomic, strong) NSNumber *ButtonTag;
//list level
@property (nonatomic, strong) NSMutableArray *listArray;
@end
