//
//  ContentPageViewController.h
//  HanKouBank
//
//  Created by David on 13-4-25.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPageViewController.h"
#import "NSString+DateToChanged.h"


@interface ContentPageViewController : UIViewController<ASIHTTPRequestDelegate>
{
    ListPageViewController *_listPageView;
}

@property (nonatomic, strong) NSMutableArray *contentDataFromListPage;

//当前页文章的docId值
@property (nonatomic, retain) NSString *Content_docIdStr;
//二层表格分栏的sortFlag值
@property (nonatomic, strong) NSString *Content_sortFlagFromList;

@property (nonatomic, strong) NSMutableArray *contentArray;

@end
