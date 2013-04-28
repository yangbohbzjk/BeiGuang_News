//
//  RegisterViewController.m
//  HanKouBank
//
//  Created by David on 13-4-28.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "RegisterViewController.h"
#import "DBLevel.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize User_textField = _User_textField;
@synthesize db = _db;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
        self.title = @"注册";
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    
    
    
    //循环五个个button tag:(0-3)+150
    NSArray *placeholderArr = [NSArray arrayWithObjects:@"  用户名",@"  密码",@"  电子邮箱",@"  真实姓名",@"手机号码", nil];
    NSArray *bgimg = [NSArray arrayWithObjects:@"login_top.png",@"headerBackground.png",@"headerBackground.png",@"headerBackground.png",@"login_buttom.png", nil];
    for (int i = 0; i<5; i++) {
        UITextField *User_textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 25+40*i, 280, 40)];
        [User_textField setPlaceholder:[NSString stringWithFormat:@"%@",[placeholderArr objectAtIndex:i]]];
        [User_textField setBackground:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[bgimg objectAtIndex:i]]]];
        [User_textField setFont:[UIFont systemFontOfSize:FONT_SYS]];
        [User_textField setTextAlignment:NSTextAlignmentLeft];
        //内容文字居中
        [User_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [User_textField setTag:i+150];
        [self.view addSubview:User_textField];
    }
    
//resgister button
    UIButton *resgisterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [resgisterButton setFrame:CGRectMake(100, 260, 120, 40)];
    [resgisterButton setTitle:@"注册" forState:UIControlStateNormal];
    [resgisterButton addTarget:self action:@selector(Resgister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resgisterButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Resgister:(UIButton *)sender
{
    self.db = [[DBLevel alloc]init];
    [self.db CopyDatabase:DBName];
   BOOL find;
  find = [self.db insertWithUserInfo:((UITextField *)[self.view viewWithTag:150+0]).text AndPass:((UITextField *)[self.view viewWithTag:150+1]).text AndEmail:((UITextField *)[self.view viewWithTag:150+2]).text AndRealname:((UITextField *)[self.view viewWithTag:150+3]).text AndUid:[NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",((UITextField *)[self.view viewWithTag:150+4]).text] intValue]]];
    
    if (find) {
        NSLog(@"1");
    }else{
        NSLog(@"0");
    }
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"申请账户成功，欢迎%@回来",((UITextField *)[self.view viewWithTag:150+0]).text] delegate:self cancelButtonTitle:@"马上登陆" otherButtonTitles: nil];
//    [alert setTag:180];
//    [alert show];
    [self.db CloseDB];
   
}

//关闭键盘方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i = 0; i<5; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:i+150];
        [field resignFirstResponder];
    }
}

//alertView imp
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 180) {
        if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        }

    }
    
}

//backBar popToSuper imple
- (void) BackBarPopToSuper
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
