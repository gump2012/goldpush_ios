//
//  ViewController.h
//  goldpush
//
//  Created by gump on 11/28/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

@class messageModel;

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITextView *_messageLabel;
    NSDictionary *_myMsg;
    
    UITableView *_tableview;
}

@property(nonatomic,strong) NSDictionary *myMsg;

@end

