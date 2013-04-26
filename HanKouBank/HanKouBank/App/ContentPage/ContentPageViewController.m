//
//  ContentPageViewController.m
//  HanKouBank
//
//  Created by David on 13-4-25.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ContentPageViewController.h"
#import "ContentLevel.h"
#import <QuartzCore/QuartzCore.h>

@interface ContentPageViewController ()

@end

@implementation ContentPageViewController
@synthesize contentDataFromListPage = _contentDataFromListPage;

@synthesize Content_docIdStr = _Content_docIdStr;
@synthesize Content_sortFlagFromList = _Content_sortFlagFromList;
@synthesize contentArray = _contentArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.Content_docIdStr = [NSMutableArray arrayWithCapacity:0];
        self.Content_sortFlagFromList = [NSMutableArray arrayWithCapacity:0];
        self.contentArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //=========================Bar===========================
    //Nav Bar bgimage
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner_background"] forBarMetrics:UIBarMetricsDefault];
    //定制 Nav Bar logo for rightBarButtonItem
    UIView *logoview = [[UIView alloc]initWithFrame:CGRectMake(310, 10, 35, 30)];
    [logoview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo.png"]]];
    UIBarButtonItem *rightLogo = [[UIBarButtonItem alloc]initWithCustomView:logoview];
    [self.navigationItem setRightBarButtonItem:rightLogo];
    
    [self.navigationItem setHidesBackButton:YES];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(15, 3, 20, 20)];
    [backButton addTarget:self action:@selector(BackBarPopToSuper) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backBar];
    //==========================END===========================
 
    NSString *url = [NSString stringWithFormat:@"%@%@/%@",Content_URL,self.Content_sortFlagFromList,self.Content_docIdStr];
    NSLog(@"content_url:%@",url);
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [request addBasicAuthenticationHeaderWithUsername:UserName andPassword:PassWord];
    request.delegate = self;
    [request setTag:220];
    [request startAsynchronous];

//    _listPageView = [[ListPageViewController alloc]init];
//    _listPageView.list_delegate = self;
//    [self HiddenBackBarWithNewYourBackBar];
    
    UIScrollView *MyScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 440)];
    [MyScroll setContentSize:CGSizeMake(320, 800)];
    [MyScroll setTag:604];
    [self.view addSubview:MyScroll];
    
    //button image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(15, 15, 290, 200)];
    [button setTag:600];
    [button setBackgroundColor:[UIColor orangeColor]];
    [MyScroll addSubview:button];
    
    //title
    UILabel *title_label = [[UILabel alloc]initWithFrame:CGRectMake(15, 230, 290, 40)];
    [title_label setFont:[UIFont boldSystemFontOfSize:16]];
    [title_label setBackgroundColor:[UIColor clearColor]];
    [title_label setTag:601];
    [title_label setNumberOfLines:2];
    [MyScroll addSubview:title_label];

    //date
    UILabel *date_label = [[UILabel alloc]initWithFrame:CGRectMake(15, 275, 150, 20)];
    [date_label setFont:[UIFont systemFontOfSize:14]];
    [date_label setBackgroundColor:[UIColor clearColor]];
    [date_label setTextColor:[UIColor grayColor]];
    [date_label setTag:602];
    [date_label setNumberOfLines:1];
    [MyScroll addSubview:date_label];
    
    //line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 300, 320, 1)];
    [line setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"newsviewflipper_boder.png"]]];
    [MyScroll addSubview:line];
    
    //content
    UILabel *content_label = [[UILabel alloc]init];
    [content_label setTag:603];
    [content_label setNumberOfLines:0];
    [content_label setTextAlignment:NSTextAlignmentCenter];
    [content_label setBackgroundColor:[UIColor clearColor]];
    [MyScroll addSubview:content_label];
    
       
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag == 220) {
        NSDictionary *dic = [[request.responseString dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
      //  [self.contentArray removeAllObjects];
        ContentLevel *contentLevel = [[ContentLevel alloc]initContentLevelWithDic:dic];
        [self.contentArray addObject:contentLevel];
    }
    //button image
    UIButton *B = (UIButton *)[self.view viewWithTag:600];
    [B setBackgroundImage:[UIImage imageNamed:@"jia.png"] forState:UIControlStateNormal];
    [B.layer setCornerRadius:6.0f];
    //图片的阴影效果
    [B.layer setShadowOffset:CGSizeMake(4.0f, 4.0f)];
    [B.layer setShadowOpacity:0.5];
    //阴影的颜色
   // [B.layer setShadowColor:[[UIColor redColor]CGColor]];
    //title_label text
    UILabel *T = (UILabel *)[self.view viewWithTag:601];
    [T setText:[NSString stringWithFormat:@"%@",((ContentLevel *)[self.contentArray objectAtIndex:0]).topic]];
    //date_label text
    UILabel *D = (UILabel *)[self.view viewWithTag:602];
    NSString *date = [[NSString alloc]init];
    date = [date YearDateToChanged:[NSString stringWithFormat:@"%@",((ContentLevel *)[self.contentArray objectAtIndex:0]).createDate]];
    [D setText:[NSString stringWithFormat:@"%@",date]];
    
    //content_label text
    UILabel *C = (UILabel *)[self.view viewWithTag:603];
    CGSize contentsize = [((ContentLevel *)[self.contentArray objectAtIndex:0]).content sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    [C setFrame:CGRectMake(15, 305, contentsize.width, contentsize.height)];
    NSString * str = [[NSString alloc]init];
    str = [str TextFilterHTML:((ContentLevel *)[self.contentArray objectAtIndex:0]).content];
    NSLog(@"self.contentA:%@",str);
    [C setText:[NSString stringWithFormat:@"%@",str]];
    
    CGRect contentFram = C.frame;
    contentFram.size.height = contentsize.height;
    C.frame = contentFram;
    [C sizeToFit];
    
    //MyScroll
    UIScrollView *S = (UIScrollView *)[self.view viewWithTag:604];
    [S setContentSize:CGSizeMake(320, 80+B.frame.size.height+T.frame.size.height+D.frame.size.height+C.frame.size.height)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//backBar popToSuper imple
- (void) BackBarPopToSuper
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
