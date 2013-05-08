//
//  MainPageViewController.h
//  HanKouBank
//
//  Created by David on 13-4-23.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "MarqueeLabel.h"

@interface MainPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>

@property (nonatomic, strong) UITableView *mTableView;

//总数据源
@property (nonatomic, strong) NSMutableDictionary *listDict;
//一层数据数组
@property (nonatomic, strong) NSMutableArray *tableTitleArray;

@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, strong) NSMutableArray *sortArray;
@property (nonatomic, strong) NSMutableArray *channelIconArray;
@property (nonatomic, strong) NSMutableArray *channelTypeArray;


//二层数据源
@property (nonatomic, strong) NSMutableArray *mArray;


@end
