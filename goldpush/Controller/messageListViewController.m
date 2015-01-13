//
//  messageListViewController.m
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messageListViewController.h"
#import "messageHandler.h"

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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -------------------tableview datasource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [messageHandler shareInstance].messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark -------------------tableview delegate----------------------

@end
