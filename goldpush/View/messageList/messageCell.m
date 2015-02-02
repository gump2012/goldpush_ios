//
//  messageCell.m
//  goldpush
//
//  Created by littest on 15/1/14.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messageCell.h"
#import "messageModel.h"
#import "messageHandler.h"

@implementation messageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 40.0f, [UIScreen mainScreen].bounds.size.width - 100.0f, 20.0f)];
        _msgLabel.adjustsFontSizeToFitWidth = YES;
        _msgLabel.numberOfLines = 0;
        [self.contentView addSubview:_msgLabel];
        _senderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen mainScreen].bounds.size.width - 100.0f, 20.0f)];
        _senderLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_senderLabel];
        
        _myMsg = nil;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)refreshWithMessage:(messageModel *)message{
    _myMsg = message;
    _msgLabel.text = message.message;
    _senderLabel.text = message.addressor;
    if (message.state == 0) {
        _senderLabel.textColor = [UIColor orangeColor];
    }else{
        _senderLabel.textColor = [UIColor blackColor];
    }
}

@end
