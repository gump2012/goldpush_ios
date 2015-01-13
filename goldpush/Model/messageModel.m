//
//  messageModel.m
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messageModel.h"

@implementation messageModel

-(id)init{
    self = [super init];
    if (self) {
        _mid = @"";
        _deviceid = @"";
        _message = @"";
        _state = 0;
    }
    return self;
}

@end
