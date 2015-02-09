//
//  messageInfoCell.m
//  goldpush
//
//  Created by littest on 15/2/9.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messageInfoCell.h"
#import "messageModel.h"
@implementation messageInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen mainScreen].bounds.size.width - 20.0f, 50.0f)];
        [self.contentView addSubview:_msgLabel];
    }
    return self;
}

-(void)refreshWithMessage:(messageModel *)message{
    if (message) {
        _msgLabel.text = message.message;
    }
}

@end
