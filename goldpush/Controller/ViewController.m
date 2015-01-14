//
//  ViewController.m
//  goldpush
//
//  Created by gump on 11/28/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "ViewController.h"
#import "pushHandler.h"
#import "confirmStateHandler.h"
#import "stateModel.h"
#import "SVProgressHUD.h"
#import "messageModel.h"
#import "messageHandler.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myMsg = _myMsg;

-(id)init{
    self = [super init];
    if (self) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 80.0f, 320.0f, 80.0f)];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = [UIFont systemFontOfSize:14.0f];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(130.0f, 280.0f, 60.0f, 40.0f)];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureBtn.layer setMasksToBounds:YES];
        [_sureBtn.layer setCornerRadius:10.0];
        _sureBtn.backgroundColor = [UIColor greenColor];
        [_sureBtn addTarget:self action:@selector(confirmStateClick:) forControlEvents:UIControlEventTouchUpInside];
        _sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(130.0f, 280.0f, 60.0f, 40.0f)];
        _sureLabel.text = @"已确认";
        _sureLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if (_myMsg) {
        if (_myMsg.state == 1) {
            _sureLabel.hidden = NO;
            _sureBtn.hidden = YES;
        }else{
            _sureLabel.hidden = YES;
            _sureBtn.hidden = NO;
        }
        
        _messageLabel.text = _myMsg.message;
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_messageLabel];
    [self.view addSubview:_sureBtn];
    [self.view addSubview:_sureLabel];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)confirmStateClick:(id)sender{
    if (_myMsg) {
        [messageHandler shareInstance].sureMsg = _myMsg;
        stateModel *state = [[stateModel alloc] init];
        state.struid = [[myStorage shareInstance] getUserID];
        state.strmid = _myMsg.mid;
        state.strstate = @"1";
        [SVProgressHUD showWithStatus:@"正在确认..."];
        [[confirmStateHandler shareInstance] executeRegist:state
                                                   success:^(id a){
                                                       [SVProgressHUD showSuccessWithStatus:@"确认成功"];
                                                       
                                                       _sureLabel.hidden = NO;
                                                       _sureBtn.hidden = YES;
                                                       
                                                       [[messageHandler shareInstance] updateMessageWithMsg];
                                                   }failed:^(id a){
                                                       [SVProgressHUD showErrorWithStatus:@"确认失败"];
                                                       
                                                       _sureLabel.hidden = YES;
                                                       _sureBtn.hidden = NO;
                                                   }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

@end
