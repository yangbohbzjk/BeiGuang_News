//
//  ListPageViewController.m
//  HanKouBank
//
//  Created by David on 13-4-24.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ListPageViewController.h"
#import "Level.h"
#import "List_Level.h"
#import "ListCell.h"
#import "NSString+DateToChanged.h"
#import "ContentPageViewController.h"

@interface ListPageViewController ()

@end

@implementation ListPageViewController

@synthesize mTableView = _mTableView;
@synthesize listDict = _listDict;
@synthesize arr = _arr;
@synthesize strArray = _strArray;
@synthesize button_url = _button_url;
@synthesize ButtonTag = _ButtonTag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.listDict = [NSMutableDictionary dictionaryWithCapacity:0];
        self.arr = [NSMutableArray arrayWithCapacity:0];
        self.strArray = [NSMutableArray arrayWithCapacity:0];
        self.idArray = [NSMutableArray arrayWithCapacity:0];
        self.sortArray = [NSMutableArray arrayWithCapacity:0];
        
        self.listArray = [NSMutableArray arrayWithCapacity:0];
        self.button_url = [[NSString alloc]init];
        self.ButtonTag = [[NSNumber alloc]initWithInt:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Nav Bar bgimage
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner_background"] forBarMetrics:UIBarMetricsDefault];
    //定制 Nav Bar logo for rightBarButtonItem
    UIView *logoview = [[UIView alloc]initWithFrame:CGRectMake(270, 15, 48, 33)];
    [logoview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo.png"]]];    
    UIBarButtonItem *rightLogo = [[UIBarButtonItem alloc]initWithCustomView:logoview];
    [self.navigationItem setRightBarButtonItem:rightLogo];
    
//    UIView *Bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
//    [Bar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_subscribe_bg.png"]]];
//    [self.view addSubview:Bar];
    UIScrollView *Bar = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [Bar setPagingEnabled:YES];
    if ([self.arr count]>4) {
        [Bar setContentSize:CGSizeMake(640, 35)];
    }else{
        [Bar setContentSize:CGSizeMake(320, 35)];}
    [Bar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_subscribe_bg.png"]]];
    [Bar setShowsHorizontalScrollIndicator:NO];
    [Bar setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:Bar];

    for (int i = 0; i<[self.arr count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(15+(60+18)*i, 5, 65, 25)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTag:i+500];
        [button addTarget:self action:@selector(Button:) forControlEvents:UIControlEventTouchUpInside];
        [Bar addSubview:button];
        
        //listpage中保存数据模型数据
        [self.strArray addObject:((Level *)[self.arr objectAtIndex:i]).text];
        [self.idArray addObject:((Level *)[self.arr objectAtIndex:i]).Id];
        [self.sortArray addObject:((Level *)[self.arr objectAtIndex:i]).sortFlag];
        
        [button setTitle:[self.strArray objectAtIndex:i] forState:UIControlStateNormal];

    }

    self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, 320, 460-80) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    //修改分割线样式
    [self.mTableView setSeparatorColor:[UIColor orangeColor]];
    [self.view addSubview:self.mTableView];
    
    //默认发送第一个button_url给表格
    if ([(UIButton *)[self.view viewWithTag:500]isEqual:NULL
         ]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有数据" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }else{
        [self Button:(UIButton *)[self.view viewWithTag:500]];}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//mTableView imple

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName =@"listCell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ListCell" owner:self options:nil]lastObject];
    }
    
    //topic
    [cell.ListCell_title setText:((List_Level *)[self.listArray objectAtIndex:[indexPath row]]).topic];
    
    //时间格式处理
    NSString *date =[[NSString alloc]init];
   date = [date DateToChanged:((List_Level *)[self.listArray objectAtIndex:[indexPath row]]).createDate];
    [cell.ListCell_date setText:date];
    //summery
    [cell.ListCell_titleless setText:((List_Level *)[self.listArray objectAtIndex:[indexPath row]]).summary];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //chat icon
    [cell.ListCell_icon setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"chat.png"]]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentPageViewController *contentPageView = [[ContentPageViewController alloc]init];
    [contentPageView setTitle:[NSString stringWithFormat:@"%@",((UIButton *)[self.view viewWithTag:[self.ButtonTag intValue]]).titleLabel.text]];
    [self.navigationController pushViewController:contentPageView animated:YES];
}

//ScrollView_Bar implement
- (void)Button:(UIButton *)sender
{
    self.ButtonTag = [NSNumber numberWithInt:sender.tag];
    //实现button按钮互斥单选
    for (int k = 0; k<[self.arr count]; k++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:k+500];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    //pn理解为sortFlag,ps是每页的内容条数
    self.button_url = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@?pn=%@&ps=%@",LIST_URL,[self.idArray objectAtIndex:(sender.tag-500)],[self.sortArray objectAtIndex:(sender.tag-500)],LIST_NUM_IMP]];
    //单击事件发送请求json
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:self.button_url]];
    [request setTag:210];
    [request addBasicAuthenticationHeaderWithUsername:UserName andPassword:PassWord];
    //测试:地址拼接成功
    request.delegate = self;
    [request startAsynchronous];
}

//request finish
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag == 210) {
        if (request.responseString==NULL) {
            NSLog(@"sdf");
        }else{
        [self.listArray removeAllObjects];
        NSArray *array = [[request.responseString dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
        for (NSDictionary *dic  in array) {
            for (NSDictionary *d in [dic objectForKey:@"content"]) {
                List_Level *list_level = [[List_Level alloc]initLevelWithDic:d];
                [self.listArray addObject:list_level];
            }
        }
    }
        [self.mTableView reloadData];

    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败！请检查网络" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
    [alert show];
}

-(void)alertViewCancel:(UIAlertView *)alertView
{
    [self Button:(UIButton *)[self.view viewWithTag:500]];
}
@end
