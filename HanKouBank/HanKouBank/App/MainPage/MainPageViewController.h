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
@interface MainPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>

@property (nonatomic, strong) UITableView *mTableView;

//总数据源
@property (nonatomic, strong) NSMutableDictionary *listDict;
//一层数据数组
@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, strong) NSMutableArray *sortArray;
@property (nonatomic, strong) NSMutableArray *channelIconArray;
@property (nonatomic, strong) NSMutableArray *channelTypeArray;


//二层数据源
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) NSMutableArray *SONS_SONSArray;
@property (nonatomic, strong) NSMutableArray *SONS_listArr;
@property (nonatomic, strong) NSMutableArray *SONS_listArray;

@property (nonatomic, strong) NSMutableArray *SONS_idArray;
@property (nonatomic, strong) NSMutableArray *SONS_textArray;
@property (nonatomic, strong) NSMutableArray *SONS_sortArray;
@property (nonatomic, strong) NSMutableArray *SONS_channelIconArray;
@property (nonatomic, strong) NSMutableArray *SONS_channelTypeArray;

@end
