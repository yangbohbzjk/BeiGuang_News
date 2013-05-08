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
#import "SDWebImageDownloader.h"
@interface MainPageViewController ()

@end

@implementation MainPageViewController

@synthesize mTableView = _mTableView;
@synthesize listDict = _listDict;
@synthesize tableTitleArray = _tableTitleArray;
@synthesize mArray = _mArray;
@synthesize idArray = _idArray;
@synthesize textArray = _textArray;
@synthesize sortArray = _sortArray;
@synthesize channelIconArray = _channelIconArray;
@synthesize channelTypeArray = _channelTypeArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
        self.listDict = [NSMutableDictionary dictionaryWithCapacity:0];
        self.tableTitleArray = [NSMutableArray arrayWithCapacity:0];
        
        
        self.mArray = [NSMutableArray arrayWithCapacity:0];

        
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
    //滚动新闻
    UIView *lanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 36)];
    [lanView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"breakingnews_bg.9.png"]]];
    [lanView setTag:280];
    [self.view addSubview:lanView];
    //滚动文字
    MarqueeLabel *rateLabelOne = [[MarqueeLabel alloc] initWithFrame:CGRectMake(15, 3, 280, 30) rate:30.0f andFadeLength:10.0f];
    rateLabelOne.numberOfLines = 1;
    rateLabelOne.opaque = NO;
    rateLabelOne.enabled = YES;
    rateLabelOne.shadowOffset = CGSizeMake(0.0, -1.0);
    rateLabelOne.textAlignment = UITextAlignmentLeft;
    rateLabelOne.textColor = [UIColor whiteColor];
    rateLabelOne.backgroundColor = [UIColor clearColor];
   // rateLabelOne.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.000];
    rateLabelOne.text = @"美国政治风险咨询公司欧亚集团总裁日前在英国《金融时报》发表文章说，日本在与中国关系恶化中损失最大。";
    [lanView addSubview:rateLabelOne];
    
    //关闭按钮
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setFrame:CGRectMake( 295, 9, 20, 20)];
    [close setImage:[UIImage imageNamed:@"closebreakingnews.png"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(CloseNew:) forControlEvents:UIControlEventTouchUpInside];
    [lanView addSubview:close];
    
    //AD
    UIButton *ADButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ADButton setFrame:CGRectMake(0, 36, 320, 120-36)];
    [ADButton setImage:[UIImage imageNamed:@"AD"] forState:UIControlStateNormal];
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
       // NSLog(@"request:%@",request.responseString);
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
            Level *mainlevel = [[Level alloc]init];
            [mainlevel titleFromJson:dic];
            [self.tableTitleArray addObject:mainlevel];

            Level *level = [[Level alloc]initLevelWithDic:dic];
            [self.mArray addObject:level];
            
        }
    
    }else if (request.tag ==201){
        
    }
    [self.listDict setObject:self.idArray forKey:@"id"];
    [self.listDict setObject:self.textArray forKey:@"text"];
    [self.listDict setObject:self.channelIconArray forKey:@"channelIcon"];
    [self.listDict setObject:self.channelTypeArray forKey:@"channelType"];
    [self.listDict setObject:self.sortArray forKey:@"sortFlag"];

    
    [self.mTableView reloadData];
}

- (void)CloseNew:(UIButton *)sender
{
    UIView *view = [self.view viewWithTag:280];
    [view setHidden:YES];
}
//广告图片链接
- (void)ADButton:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"接口未提供相应链接！" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alert show];
}

//编辑按钮
- (void)EditButton:(UIButton *)sender
{
    [self setEditing:YES animated:YES];
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
    [cell.MainCell_Title setText:[NSString stringWithFormat:@"%@",((Level *)[self.tableTitleArray objectAtIndex:[indexPath row]]).text]];
    
    [SDWebImageManager.sharedManager.imageDownloader setValue:UserName forHTTPHeaderField:PassWord];
    SDWebImageManager.sharedManager.imageDownloader.queueMode = SDWebImageDownloaderLIFOQueueMode;
    
    [cell.MainCell_ImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[self.listDict objectForKey:@"channelIcon"] objectAtIndex:[indexPath row]]]]];
   
    //[cell.MainCell_ImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",((Level *)[self.tableTitleArray objectAtIndex:[indexPath row]]).channelIcon]]];
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        
        [[self.listDict objectForKey:@"text"] removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
        [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.0];
        
        
    }
    
    
    
}

-(void)reloadTableView{
    
    [self.mTableView reloadData];
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
    
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    
    [self.mTableView setEditing:editing animated:animated];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [[self.listDict objectForKey:@"text"]count];
}
@end
