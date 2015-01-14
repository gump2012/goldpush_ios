//
//  messageCell.h
//  goldpush
//
//  Created by littest on 15/1/14.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MSG_CELL_H  60.0f

@class messageModel;

@interface messageCell : UITableViewCell
{
    UILabel     *_msgLabel;
    UIButton    *_sureBtn;
    UILabel     *_sureLabel;
    messageModel *_myMsg;
}

-(void)refreshWithMessage:(messageModel *)message;

@end
