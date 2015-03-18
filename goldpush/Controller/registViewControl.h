//
//  registViewControl.h
//  goldpush
//
//  Created by gump on 12/10/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

@class registModel;

@interface registViewControl : UIViewController
{
    UILabel *_userNameLabel;
    UILabel *_psLabel;
    UITextField *_phonetext;
    UITextField *_pstext;
    UIButton *_surebtn;
    registModel *_regis;
    UIButton *_remenberBtn;
    UIButton *_autoBtn;
}
@end
