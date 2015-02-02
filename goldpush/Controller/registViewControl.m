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
#import "messageListViewController.h"

@implementation registViewControl

-(id)init{
    self = [super init];
    if (self) {
        _phonetext = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, 100.0f, 240.0f, 40.0f)];
        _phonetext.placeholder = @"请输入手机号码";
        _phonetext.keyboardType= UIKeyboardTypeNumberPad;
        
        _surebtn = [[UIButton alloc] initWithFrame:CGRectMake(130.0f, 180.0f, 60.0f, 40.0f)];
        [_surebtn setTitle:@"注册" forState:UIControlStateNormal];
        [_surebtn.layer setMasksToBounds:YES];
        [_surebtn.layer setCornerRadius:10.0];
        _surebtn.backgroundColor = [UIColor greenColor];
        [_surebtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getUserProfileSuccess:)
                                                     name:NOTI_GETUID
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getUserProfileFail:)
                                                     name:NOTI_GETUIDFAIL
                                                   object:nil];
        
        _regis = [[registModel alloc] init];
        
        self.title = @"注册";
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getUserProfileSuccess:(NSNotification*) aNotification{
    //[SVProgressHUD showSuccessWithStatus:@"成功获得设备id"];
    
    NSDictionary *nameDictionary = [aNotification userInfo];
    NSString *strname = [nameDictionary objectForKey:@"name"];
    _regis.userid = strname;
    
    [self performSelector:@selector(changeText:) withObject:nil afterDelay:1];
}

-(void)getUserProfileFail:(NSNotification*) aNotification{
    [SVProgressHUD showErrorWithStatus:@"网络故障，请检查您的网络"];
    
    _regis.userid = @"";
    
    [self performSelector:@selector(changeText:) withObject:nil afterDelay:1];
}

-(void)viewDidLoad{
    [self.view addSubview:_phonetext];
    [self.view addSubview:_surebtn];
    
    //[SVProgressHUD showWithStatus:@"正在获得设备id"];
}

-(void)registerClick:(id)sender{
    if (_phonetext.text.length != 11) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入11位手机号" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
    }else{
        _regis.phonenum = _phonetext.text;
        [_phonetext resignFirstResponder];
        [SVProgressHUD showWithStatus:@"正在注册。。。"];
        [[registHandler shareInstance] executeRegist:_regis
                                             success:^(id a){
            
                                                 [[myStorage shareInstance] setRegitsStates:YES];
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            messageListViewController *view = [[messageListViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
    }
                                              failed:^(id a){
            [[myStorage shareInstance] setRegitsStates:NO];
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
    }
         ];
    }
}

-(void)changeText:(id)sender{
    [_phonetext becomeFirstResponder];
}

@end
