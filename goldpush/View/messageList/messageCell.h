//
//  messageCell.h
//  goldpush
//
//  Created by littest on 15/1/14.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MSG_CELL_H  50.0f

@class messageModel;

@interface messageCell : UITableViewCell
{
    UILabel     *_msgLabel;
    UILabel     *_senderLabel;
    messageModel *_myMsg;
}

-(void)refreshWithMessage:(NSDictionary *)message;

@end
