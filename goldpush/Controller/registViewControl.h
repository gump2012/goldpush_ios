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
    UITextField *_phonetext;
    UIButton *_surebtn;
    registModel *_regis;
}
@end
