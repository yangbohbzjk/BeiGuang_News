//
//  MainPageViewController.m
//  HanKouBank
//
//  Created by David on 13-4-23.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "MainPageViewController.h"
#import "MainCell.h"
#import "UIImageView+WebCache.h"
#import "ListPageViewController.h"
#import "Level.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

@synthesize mTableView = _mTableView;
@synthesize listDict = _listDict;
@synthesize mArray = _mArray;
@synthesize idArray = _idArray;
@synthesize textArray = _textArray;
@synthesize sortArray = _sortArray;
@synthesize channelIconArray = _channelIconArray;
@synthesize channelTypeArray = _channelTypeArray;

@synthesize SONS_SONSArray = _SONS_SONSArray;
@synthesize SONS_listArr = _SONS_listArr;
@synthesize SONS_listArray = _SONS_listArray;
@synthesize SONS_channelIconArray = _SONS_channelIconArray;
@synthesize SONS_channelTypeArray = _SONS_channelTypeArray;
@synthesize SONS_idArray = _SONS_idArray;
@synthesize SONS_sortArray = _SONS_sortArray;
@synthesize SONS_textArray = _SONS_textArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.listDict = [NSMutableDictionary dictionaryWithCapacity:0];
        self.SONS_listArray = [NSMutableArray arrayWithCapacity:0];
        self.SONS_listArr = [NSMutableArray arrayWithCapacity:0];
        self.SONS_SONSArray = [NSMutableArray arrayWithCapacity:0];
        self.mArray = [NSMutableArray arrayWithCapacity:0];
        self.SONS_idArray = [NSMutableArray arrayWithCapacity:0];
        self.SONS_textArray = [NSMutableArray arrayWithCapacity:0];
        self.SONS_sortArray = [NSMutableArray arrayWithCapacity:0];
        self.SONS_channelIconArray = [NSMutableArray arrayWithCapacity:0];
        self.SONS_channelTypeArray = [NSMutableArray arrayWithCapacity:0];
        
        self.idArray = [NSMutableArray arrayWithCapacity:0];
        self.textArray = [NSMutableArray arrayWithCapacity:0];
        self.sortArray = [NSMutableArray arrayWithCapacity:0];
        self.channelIconArray = [NSMutableArray arrayWithCapacity:0];
        self.channelTypeArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //nav Bar backgroundImage
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner_background.png"] forBarMetrics:UIBarMetricsDefault];
    //nav Bar titleView
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(100, 2,197,30 )];
    [titleview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_banner_text"]]];
    [self.navigationItem setTitleView:titleview];
    //right Bar from logo
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(310, 10, 35, 30)];
    [rightView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo"]]];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //AD
    UIButton *ADButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ADButton setFrame:CGRectMake(0, 0, 320, 120)];
    [ADButton setImage:[UIImage imageNamed:@"mainpage_ad"] forState:UIControlStateNormal];
    [ADButton addTarget:self action:@selector(ADButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ADButton];
    
    //Bar
    UIView *yellowBar = [[UIView alloc]initWithFrame:CGRectMake(0, 120, 320, 35)];
    [yellowBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_subscribe_bg.png"]]];
    [self.view addSubview:yellowBar];
    //label
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 100, 30)];
    [title setText:@"我的订阅"];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setTextColor:[UIColor blackColor]];
    [title setFont:[UIFont boldSystemFontOfSize:22]];
    [yellowBar addSubview:title];
    
    //edit button
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setFrame:CGRectMake(120, 5, 70, 27)];
    [editButton setImage:[UIImage imageNamed:@"mysubscribe_button_bg.png"] forState:UIControlStateNormal];
    [editButton setImage:[UIImage imageNamed:@"mysubscribe_button_bg_press.png"] forState:UIControlStateHighlighted];
    [editButton setBackgroundColor:[UIColor clearColor]];
    [editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *editTitle = [[UILabel alloc]initWithFrame:editButton.bounds];
    [editTitle setText:@"编辑"];
    [editTitle setTextAlignment:NSTextAlignmentCenter];
    [editTitle setTextColor:[UIColor blackColor]];
    [editTitle setFont:[UIFont systemFontOfSize:18]];
    [editTitle setBackgroundColor:[UIColor clearColor]];
    [editButton addSubview:editTitle];
    
    [yellowBar addSubview:editButton];
    
    //mTableView                     self.view.frame.size.height
    self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, 320, 460-205) style:UITableViewStylePlain];
    [self.mTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablebg"]]];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
    
    
    //登陆成功后开始解析
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:LOGIN_URL]];
    [request setTag:200];
    [request addBasicAuthenticationHeaderWithUsername:UserName andPassword:PassWord];
    request.delegate = self;
    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ASI imple
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag == 200) {
        NSLog(@"request:%@",request.responseString);
        //json
        NSDictionary *arr = [[request.responseString dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
      //  NSLog(@"arr:%@",arr);
        for (NSDictionary *dic in arr)
        {
            [self.idArray addObject:[dic objectForKey:@"id"]];
            [self.textArray addObject:[dic objectForKey:@"text"]];
            [self.sortArray addObject:[dic objectForKey:@"sortFlag"]];
            [self.channelTypeArray addObject:[dic objectForKey:@"channelType"]];
            //            ASIHTTPRequest *request_image = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"channelIcon"]]]];
            //            [request_image setTag:201];
            //            [request_image addBasicAuthenticationHeaderWithUsername:UserName andPassword:PassWord];
            //            request_image.delegate = self;
            //            [request_image startAsynchronous];
            
            //===============假数据测试部分============
            [self.channelIconArray addObjectsFromArray:[NSArray arrayWithObjects:@"hongguan.png",@"hangye.png",@"zhuanti.png",@"shidian.png",@"neixun.png",@"qita.png", nil]];
            //============END========================
            
            Level *level = [[Level alloc]initLevelWithDic:dic];
            [self.mArray addObject:level];
        }
    
    }else if (request.tag ==201){
        
        //        NSData *data = [request.responseData objectFromJSONData];
        //        [self.channelIconArray addObject:data];
    }
    [self.listDict setObject:self.idArray forKey:@"id"];
    [self.listDict setObject:self.textArray forKey:@"text"];
    [self.listDict setObject:self.channelIconArray forKey:@"channelIcon"];
    [self.listDict setObject:self.channelTypeArray forKey:@"channelType"];
    [self.listDict setObject:self.sortArray forKey:@"sortFlag"];

    
    [self.mTableView reloadData];
}
//广告图片链接
- (void)ADButton:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有写事件！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alert show];
}

//编辑按钮
- (void)EditButton:(UIButton *)sender
{
    NSLog(@"edit button");
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName =@"mainTable";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MainCell" owner:self options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell.MainCell_Title setText:[NSString stringWithFormat:@"%@",[[self.listDict objectForKey:@"text"] objectAtIndex:[indexPath row]]]];
   
    [cell.MainCell_ImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[self.listDict objectForKey:@"channelIcon"] objectAtIndex:[indexPath row]]]]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.listDict objectForKey:@"text"]count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListPageViewController *listPageView = [[ListPageViewController alloc]init];
    [listPageView.navigationItem setTitle:[NSString stringWithFormat:@"%@",[[self.listDict objectForKey:@"text"] objectAtIndex:[indexPath row]]]];
    listPageView.arr = ((Level *)[self.mArray objectAtIndex:[indexPath row]]).sons ;
    [self.navigationController pushViewController:listPageView animated:YES];
}

@end
