//
//  operateViewController.m
//  goldpush
//
//  Created by littest on 15/3/19.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "operateViewController.h"

@interface operateViewController ()

@end

@implementation operateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"铁路运营";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
