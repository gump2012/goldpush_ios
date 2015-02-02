//
//  messageListViewController.m
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messageListViewController.h"
#import "messageHandler.h"
#import "messageCell.h"
#import "SVProgressHUD.h"
#import "stateModel.h"
#import "messageModel.h"
#import "confirmStateHandler.h"
#import "ViewController.h"
#import "messagedb.h"

@interface messageListViewController ()

@end

@implementation messageListViewController

-(id)init{
    self = [super init];
    if (self) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                   [UIScreen mainScreen].bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.height)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getPushWhenRun:)
                                                     name:NOTI_GETPUSHWHENRUN
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getLastMsg:)
                                                     name:NOTI_GETLASTMSG
                                                   object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getPushWhenRun:(NSNotification*) aNotification{
    [_tableview reloadData];
}

-(void)getLastMsg:(NSNotification*) aNotification{
    [_tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_tableview];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"消息列表";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -------------------tableview datasource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [messageHandler shareInstance].messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"messageCell";
    messageCell *cell = (messageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[messageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row < [messageHandler shareInstance].messageArr.count) {
        messageModel *message = [messageHandler shareInstance].messageArr[indexPath.row];
        [cell refreshWithMessage:message];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)sureClick:(id)sender{
    if ([messageHandler shareInstance].sureMsg) {
        [SVProgressHUD showWithStatus:@"正在确认..."];
        
        stateModel *state = [[stateModel alloc] init];
        state.struid = [[myStorage shareInstance] getUserID];
        state.strmid = [messageHandler shareInstance].sureMsg.mid;
        state.strstate = @"1";
        [[confirmStateHandler shareInstance] executeRegist:state
                                                   success:^(id a){
                                                       [SVProgressHUD showSuccessWithStatus:@"确认成功!"];
                                                       
                                                       [[messageHandler shareInstance] updateMessageWithMsg];
                                                       [_tableview reloadData];
                                                   }failed:^(id a){
                                                       [SVProgressHUD showErrorWithStatus:@"确认失败"];
                                                   }];
    }
}

#pragma mark -------------------tableview delegate----------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MSG_CELL_H;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < [messageHandler shareInstance].messageArr.count) {
        messageModel *message = [messageHandler shareInstance].messageArr[indexPath.row];
        if (message) {
            ViewController *view = [[ViewController alloc] init];
            view.myMsg = message;
            
            [self.navigationController pushViewController:view animated:YES];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        messageModel *msg = [[messageHandler shareInstance].messageArr objectAtIndex:indexPath.row];
        [[messagedb shareInstance] deleteMsg:msg];
        [[messageHandler shareInstance].messageArr removeObjectAtIndex:indexPath.row];
        
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
@end
