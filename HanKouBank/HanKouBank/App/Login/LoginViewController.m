//
//  LoginViewController.m
//  HanKouBank
//
//  Created by David on 13-4-23.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "LoginViewController.h"
#import "MainPageViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize mTableView = _mTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //view backgroundColor
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    //nav Bar backgroundImage
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_banner.9.png"] forBarMetrics:UIBarMetricsDefault];
    //mTableView
    self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 15, 280, 105) style:UITableViewStyleGrouped];
    [self.mTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tablebg"]]];
    [self.mTableView setScrollEnabled:NO];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
    
    
    
    //forgot pass button
    UIButton *ForgotPass = [UIButton buttonWithType:UIButtonTypeCustom];
    [ForgotPass setFrame:CGRectMake(20, 140, 90,  30)];
    [ForgotPass setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [ForgotPass setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [ForgotPass addTarget:self action:@selector(Forgot:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ForgotPass];
    
    //resgister button
    UIButton *resgisterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [resgisterButton setFrame:CGRectMake(10, 180, 120, 40)];
    [resgisterButton setTitle:@"注册" forState:UIControlStateNormal];
    [resgisterButton addTarget:self action:@selector(Resgister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resgisterButton];

    //login button
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(150, 180, 120, 40)];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)Forgot:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"这里还没有实现～" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
}

- (void)Resgister:(UIButton *)sender
{
    NSLog(@"注册");
}

- (void)Login:(UIButton *)sender
{
    UITextField *name = (UITextField *)[self.view viewWithTag:100];
    UITextField *pass = (UITextField *)[self.view viewWithTag:101];
    if (name.text == nil || pass.text == nil) {
        //如果密码为空，提示
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入账号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else if ([name.text isEqualToString:@"hankou"]&&[pass.text isEqualToString:@"hankou"]){
        //如果账号密码为测试账号，则进入主页面
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"欢迎回来" message:[NSString stringWithFormat:@"登陆成功!欢迎你%@",name.text] delegate:self cancelButtonTitle:@"进入主页" otherButtonTitles:nil];
        [alert show];
               
        
        MainPageViewController *mainPageView = [[MainPageViewController alloc]init];
        [self.navigationController pushViewController:mainPageView animated:YES];

        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"异常" message:@"账号登陆异常，请重新登陆" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//mTableView implement
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName =@"cellname";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];

    if (indexPath.row == 0) {
        
        UITextField *username = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.origin.x+11, cell.frame.origin.y+5, cell.frame.size.width-52,cell.frame.size.height-8 )];
        [username setBackgroundColor:[UIColor clearColor]];
        [username setPlaceholder:@"    用户名"];
        [username setTag:100];
        [username setTextAlignment:NSTextAlignmentLeft];
        [username setFont:[UIFont systemFontOfSize:24]];
        [cell addSubview:username];
    }else if(indexPath.row == 1){
        UITextField *userpass = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.origin.x+11, cell.frame.origin.y+5, cell.frame.size.width-52,cell.frame.size.height-8 )];
        [userpass setBackgroundColor:[UIColor clearColor]];
        [userpass setPlaceholder:@"    密 码"];
        [userpass setTag:101];
        [userpass setTextAlignment:NSTextAlignmentLeft];
        [userpass setFont:[UIFont systemFontOfSize:24]];
        [cell addSubview:userpass];
    }
  
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextField *name = (UITextField *)[self.view viewWithTag:100];
    UITextField *pass = (UITextField *)[self.view viewWithTag:101];
    [name resignFirstResponder];
    [pass resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}




@end
