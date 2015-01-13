//
//  messageListViewController.h
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messageListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
}
@end
