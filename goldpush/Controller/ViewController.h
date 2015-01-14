//
//  ViewController.h
//  goldpush
//
//  Created by gump on 11/28/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

@class messageModel;

@interface ViewController : UIViewController
{
    UILabel *_messageLabel;
    UIButton *_sureBtn;
    messageModel *_myMsg;
    UILabel *_sureLabel;
}

@property(nonatomic,strong) messageModel *myMsg;

@end

