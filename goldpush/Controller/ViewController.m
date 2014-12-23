//
//  ViewController.m
//  goldpush
//
//  Created by gump on 11/28/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "ViewController.h"
#import "pushHandler.h"

@interface ViewController ()

@end

@implementation ViewController

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
    NSDictionary *apsdic = [[pushHandler shareInstance].curPush objectForKey:@"aps"];
    if (apsdic) {
        NSString *stralert = [apsdic objectForKey:@"alert"];
        if (stralert) {
            _messageLabel.text = stralert;
        }
    }
}

- (void) getUserProfileSuccess: (NSNotification*) aNotification
{
    NSDictionary *nameDictionary = [aNotification userInfo];
    _messageLabel.text = [nameDictionary objectForKey:@"name"];
}

-(void)viewWillAppear:(BOOL)animated{
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    NSDictionary *apsdic = [[pushHandler shareInstance].curPush objectForKey:@"aps"];
    if (apsdic) {
        NSString *stralert = [apsdic objectForKey:@"alert"];
        if (stralert) {
            _messageLabel.text = stralert;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_messageLabel];
    [self.view addSubview:_sureBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
