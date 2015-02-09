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
#import "messagedb.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myMsg = _myMsg;

-(id)init{
    self = [super init];
    if (self) {
        _messageLabel = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 10.0f,
                                                                     [UIScreen mainScreen].bounds.size.width,
                                                                     [UIScreen mainScreen].bounds.size.height - 20.0f)];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
//    if (_myMsg) {
//        if (_myMsg.state == 0) {
//            [messageHandler shareInstance].sureMsg = _myMsg;
//            stateModel *state = [[stateModel alloc] init];
//            state.struid = [[myStorage shareInstance] getUserID];
//            state.strmid = _myMsg.mid;
//            state.strstate = @"1";
//            [SVProgressHUD showWithStatus:@"正在确认..."];
//            [[confirmStateHandler shareInstance] executeRegist:state
//                                                       success:^(id a){
//                                                           [SVProgressHUD showSuccessWithStatus:@"确认成功"];
//                                                           [[messageHandler shareInstance] updateMessageWithMsg];
//                                                       }failed:^(id a){
//                                                           [SVProgressHUD showErrorWithStatus:@"确认失败"];
//                                                       }];
//        }
//        
//        _messageLabel.text = _myMsg.message;
//        
//        if (_myMsg.truncate == 1) {
//            [[messageHandler shareInstance] executeGetLongText:_myMsg.mid
//        success:^(id a){
//            if (a) {
//                _myMsg.message = (NSString *)a;
//                _messageLabel.text = _myMsg.message;
//                _myMsg.truncate = 0;
//                [[messagedb shareInstance] updateMsg:_myMsg];
//            }
//            
//            
//        }failed:^(id a){
//            NSLog(@"executeGetLongText faild");
//        }];
//        };
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_messageLabel];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if (_myMsg) {
        self.title = [_myMsg objectForKey:@"addressor"];
    }else{
        self.title = @"消息内容";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
