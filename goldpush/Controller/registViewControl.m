//
//  registViewControl.m
//  goldpush
//
//  Created by gump on 12/10/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "registViewControl.h"
#import "SVProgressHUD.h"
#import "registModel.h"
#import "registHandler.h"
#import "operateViewController.h"

@implementation registViewControl

-(id)init{
    self = [super init];
    if (self) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 80.0f, 100.0f, 40.0f)];
        _userNameLabel.text = @"用户名:";
        
        _phonetext = [[UITextField alloc] initWithFrame:CGRectMake(140.0f, 80.0f, 180.0f, 40.0f)];
        _phonetext.placeholder = @"请输入用户名";
        
        _psLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 140.0f, 100.0f, 40.0f)];
        _psLabel.text = @"密码:";
        
        _pstext = [[UITextField alloc] initWithFrame:CGRectMake(140.0f, 140.0f, 180.0f, 40.0f)];
        _pstext.placeholder = @"请输入密码";
        _pstext.secureTextEntry = YES;
        
        _surebtn = [[UIButton alloc] initWithFrame:CGRectMake((WINDOW_WIDTH - 225.0f)/2.0f, 250.0f, 225.0f, 35.0f)];
        [_surebtn setImage:[UIImage imageNamed:@"loginbtn"] forState:UIControlStateNormal];
        [_surebtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _remenberBtn = [[UIButton alloc] initWithFrame:CGRectMake(20.0f, 200.0f, 25.0f, 25.0f)];
        if ([[myStorage shareInstance] rememberPS]) {
            [_remenberBtn setImage:[UIImage imageNamed:@"loginselect"] forState:UIControlStateNormal];
        }else{
            [_remenberBtn setImage:[UIImage imageNamed:@"loginunselect"] forState:UIControlStateNormal];
        }
        [_remenberBtn addTarget:self action:@selector(clickRemember) forControlEvents:UIControlEventTouchUpInside];
        
        _autoBtn = [[UIButton alloc] initWithFrame:CGRectMake(170.0f, 200.0f, 25.0f, 25.0f)];
        if ([[myStorage shareInstance] autoLogin]) {
            [_autoBtn setImage:[UIImage imageNamed:@"loginselect"] forState:UIControlStateNormal] ;
        }else {
            [_autoBtn setImage:[UIImage imageNamed:@"loginunselect"] forState:UIControlStateNormal] ;
        }
        [_autoBtn addTarget:self action:@selector(clickAuto) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getUserProfileSuccess:)
                                                     name:NOTI_GETUID
                                                   object:nil];
         
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getUserProfileFail:)
                                                     name:NOTI_GETUIDFAIL
                                                   object:nil];
        
        _regis = [[registModel alloc] init];
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getUserProfileSuccess:(NSNotification*) aNotification{
    
    NSDictionary *nameDictionary = [aNotification userInfo];
    NSString *strname = [nameDictionary objectForKey:@"name"];
    _regis.userid = strname;
    
    if ([[myStorage shareInstance]  autoLogin]) {
        _regis.phonenum = [[myStorage shareInstance] userName];
        _regis.ps = [[myStorage shareInstance] userPassword];
        if (_regis.phonenum.length > 0 && _regis.ps.length > 0) {
            [_phonetext resignFirstResponder];
            [_pstext resignFirstResponder];
            [SVProgressHUD showWithStatus:@"正在登录。。。"];
            [[registHandler shareInstance] executeRegist:_regis
                                                 success:^(id a){
                                                     [[myStorage shareInstance] setRegitsStates:YES];
                                                     [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                                                     
                                                     [[myStorage shareInstance] setUserName:_regis.phonenum];
                                                     [[myStorage shareInstance] setUserPassword:_regis.ps];
                                                     operateViewController *view = [[operateViewController alloc] init];
                                                     [self.navigationController pushViewController:view animated:YES];
                                                 }
                                                  failed:^(id a){
                                                      [[myStorage shareInstance] setRegitsStates:NO];
                                                      [SVProgressHUD showErrorWithStatus:@"登录失败"];
                                                  }
             ];
        }
    }
}

-(void)getUserProfileFail:(NSNotification*) aNotification{
    [SVProgressHUD showErrorWithStatus:@"网络故障，请检查您的网络"];
    
    _regis.userid = @"";
}

-(void)viewDidLoad{
    self.navigationController.navigationBar.hidden = YES;
    
    UIImageView *bgview = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, WINDOW_WIDTH, WINDOW_HIGHT)];
    bgview.image = [UIImage imageNamed:@"loginbg"];
    bgview.userInteractionEnabled = YES;
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickbg:)];
    [bgview addGestureRecognizer:singleRecognizer];
    [self.view addSubview:bgview];
    
    UILabel *remenberLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 200.0f, 100.0f, 30.0f)];
    remenberLabel.text = @"记住密码";
    
    UILabel *autoLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 200.0f, 100.0f, 30.0f)];
    autoLabel.text = @"自动登录";
    
    [self.view addSubview:_phonetext];
    [self.view addSubview:_surebtn];
    [self.view addSubview:_userNameLabel];
    [self.view addSubview:_pstext];
    [self.view addSubview:_psLabel];
    [self.view addSubview:_remenberBtn];
    [self.view addSubview:_autoBtn];
    [self.view addSubview:remenberLabel];
    [self.view addSubview:autoLabel];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    _phonetext.text = [[myStorage shareInstance] userName];
    if ([[myStorage shareInstance] rememberPS]) {
        _pstext.text = [[myStorage shareInstance] userPassword];
    }else{
        _pstext.text = @"";
    }
}

-(void)registerClick:(id)sender{
    if (_phonetext.text.length == 0 || _pstext.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名或密码" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
        [alert show];
    }else{
        _regis.phonenum = _phonetext.text;
        _regis.ps = _pstext.text;
        [_phonetext resignFirstResponder];
        [_pstext resignFirstResponder];
        [SVProgressHUD showWithStatus:@"正在登录。。。"];
        [[registHandler shareInstance] executeRegist:_regis
                                             success:^(id a){
                                                 [[myStorage shareInstance] setRegitsStates:YES];
                                                 [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                                                 
                                                 [[myStorage shareInstance] setUserName:_regis.phonenum];
                                                 [[myStorage shareInstance] setUserPassword:_regis.ps];
                                                 operateViewController *view = [[operateViewController alloc] init];
                                                 [self.navigationController pushViewController:view animated:YES];
                                             }
                                              failed:^(id a){
                                                  [[myStorage shareInstance] setRegitsStates:NO];
                                                  [SVProgressHUD showErrorWithStatus:@"登录失败"];
                                              }
         ];
    }
}

-(void)changeText:(id)sender{
    if ([_phonetext isFirstResponder] || [_pstext isFirstResponder]) {
        return;
    }
    [_phonetext becomeFirstResponder];
}

-(void)clickRemember{
    if ([[myStorage shareInstance] rememberPS]) {
        [_remenberBtn setImage:[UIImage imageNamed:@"loginunselect"] forState:UIControlStateNormal];
        [[myStorage shareInstance] setRememberPS:NO];
    }else{
        [_remenberBtn setImage:[UIImage imageNamed:@"loginselect"] forState:UIControlStateNormal];
        [[myStorage shareInstance] setRememberPS:YES];
    }
}

-(void)clickAuto{
    if ([[myStorage shareInstance] autoLogin]) {
        [_autoBtn setImage:[UIImage imageNamed:@"loginunselect"] forState:UIControlStateNormal];
        [[myStorage shareInstance] setAutoLogin:NO];
    }else{
        [_autoBtn setImage:[UIImage imageNamed:@"loginselect"] forState:UIControlStateNormal];
        [[myStorage shareInstance] setAutoLogin:YES];
    }
}

- (void)clickbg:(UISwipeGestureRecognizer*)recognizer {
    if ([_phonetext isFirstResponder]) {
        [_phonetext resignFirstResponder];
    }else if([_pstext isFirstResponder]){
        [_pstext resignFirstResponder];
    }
}

@end
