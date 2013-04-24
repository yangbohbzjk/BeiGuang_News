//
//  ListPageViewController.m
//  HanKouBank
//
//  Created by David on 13-4-24.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ListPageViewController.h"

@interface ListPageViewController ()

@end

@implementation ListPageViewController

@synthesize mTableView = _mTableView;
@synthesize listDict = _listDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.listDict = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Nav Bar bgimage
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner_background"] forBarMetrics:UIBarMetricsDefault];
    
    UIView *Bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [Bar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_subscribe_bg.png"]]];
    [self.view addSubview:Bar];
    
    NSArray *array = [NSArray arrayWithObjects:@"国际财经",@"国内财经",@"产业动态",@"财经声音", nil];
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(15+(60+15)*i, 5, 65, 25)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setFont:[UIFont boldSystemFontOfSize:16]];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTag:i+500];
        [button addTarget:self action:@selector(Button:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [Bar addSubview:button];
        
    }
    
    self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, 320, 460-35) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//mTableView imple

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName =@"mainTable";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }

    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)Button:(UIButton *)sender
{
    if (sender.tag == 0+500) {
        NSLog(@"0 button");
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else if (sender.tag == 1+500){
        NSLog(@"1 button");
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }else if (sender.tag == 2+500){
        NSLog(@"2 button");
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }else if (sender.tag == 3+500){
        NSLog(@"3 button");
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
}

@end
