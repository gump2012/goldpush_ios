//
//  getMessage.h
//  goldpush
//
//  Created by littest on 15/1/14.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "baseRequest.h"

@class messageModel;
@interface getMessage : baseRequest

+ (getMessage *)shareInstance;
-(void)requestWithMessage:(messageModel *)message;

@end
