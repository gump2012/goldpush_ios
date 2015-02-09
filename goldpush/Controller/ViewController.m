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
#import "messageInfoCell.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myMsg = _myMsg;

-(id)init{
    self = [super init];
    if (self) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                   [UIScreen mainScreen].bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.height)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if (_myMsg) {
        NSMutableArray *arr = [_myMsg objectForKey:@"messagearr"];
        if (arr) {
            for (int i = 0; i < arr.count; ++i) {
                messageModel *msg = [arr objectAtIndex:i];
                stateModel *state = [[stateModel alloc] init];
                state.struid = [[myStorage shareInstance] getUserID];
                state.strmid = msg.mid;
                state.strstate = @"1";
                [[confirmStateHandler shareInstance] executeRegist:state
                                                           success:^(id a){
                                                               [[messageHandler shareInstance] updateMessageWithMsg:msg];
                                                           }failed:^(id a){
                                                           }];
            }
        }
    }
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
    [self.view addSubview:_tableview];
    
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

#pragma mark -------------------tableview datasource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int icount = 0;
    if (_myMsg) {
        NSMutableArray *arr = [_myMsg objectForKey:@"messagearr"];
        if (arr) {
            icount = arr.count;
        }
    }
    return icount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"messageInfoCell";
    messageInfoCell *cell = (messageInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[messageInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_myMsg) {
        NSArray *arr = [_myMsg objectForKey:@"messagearr"];
        if (arr && indexPath.row < arr.count) {
            messageModel *msg = [arr objectAtIndex:indexPath.row];
            [cell refreshWithMessage:msg];
        }
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -------------------tableview delegate----------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
@end
