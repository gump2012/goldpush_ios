//
//  messageInfoCell.h
//  goldpush
//
//  Created by littest on 15/2/9.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import <UIKit/UIKit.h>
@class messageModel;
@interface messageInfoCell : UITableViewCell
{
    UILabel     *_msgLabel;
}

-(void)refreshWithMessage:(messageModel *)message;

@end
