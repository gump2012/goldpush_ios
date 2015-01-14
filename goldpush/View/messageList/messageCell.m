//
//  messageCell.m
//  goldpush
//
//  Created by littest on 15/1/14.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messageCell.h"
#import "messageModel.h"

@implementation messageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen mainScreen].bounds.size.width - 100.0f, 40.0f)];
        _msgLabel.adjustsFontSizeToFitWidth = YES;
        _msgLabel.numberOfLines = 0;
        [self.contentView addSubview:_msgLabel];
        
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 90.0f, 10.0f, 80.0f, 40.0f)];
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureBtn.layer setMasksToBounds:YES];
        [_sureBtn.layer setCornerRadius:10.0];
        _sureBtn.backgroundColor = [UIColor greenColor];
        [_sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_sureBtn];
        
        _sureLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10.0f, 10.0f, 80.0f, 40.0f)];
        _sureLabel.adjustsFontSizeToFitWidth = YES;
        _sureLabel.numberOfLines = 0;
        _sureLabel.text = @"已确认";
        [self.contentView addSubview:_sureLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)refreshWithMessage:(messageModel *)message{
    _msgLabel.text = message.message;
    if (message.state == 0) {
        _sureLabel.hidden = YES;
        _sureBtn.hidden = NO;
    }else{
        _sureLabel.hidden = NO;
        _sureBtn.hidden = YES;
    }
}

-(void)sureClick:(id)sender{
    
}

@end
