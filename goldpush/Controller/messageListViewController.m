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
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getPushWhenRun:(NSNotification*) aNotification{
    [_tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_tableview];
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
#pragma mark -------------------tableview delegate----------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MSG_CELL_H;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
