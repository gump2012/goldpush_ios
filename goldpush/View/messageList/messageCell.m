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
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100.0f, 10.0f, 100.0f, 30.0f)];
        [self.contentView addSubview:_msgLabel];
        _senderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen mainScreen].bounds.size.width - 100.0f, 30.0f)];
        _senderLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_senderLabel];
        
        _myMsg = nil;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)refreshWithMessage:(NSDictionary *)message{
    if (message) {
        NSString *str = [message objectForKey:@"addressor"];
        if (str) {
            _senderLabel.text = str;
        }
        
        NSNumber *icount = [message objectForKey:@"unreadcount"];
        if (icount.intValue > 0) {
            _senderLabel.textColor = [UIColor orangeColor];
            _msgLabel.hidden = NO;
            _msgLabel.textColor = [UIColor orangeColor];
            _msgLabel.text = [NSString stringWithFormat:@"(%d)",icount.intValue];
        }else{
            _msgLabel.hidden = YES;
            _senderLabel.textColor = [UIColor blackColor];
        }
    }
}

@end
