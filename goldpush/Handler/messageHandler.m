//
//  messageHandler.m
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messageHandler.h"
#import "messagedb.h"
#import "getMessage.h"

static messageHandler * shareins = nil;

@implementation messageHandler

+ (messageHandler *)shareInstance
{
    if (nil == shareins)
    {
        shareins = [[messageHandler alloc] init];
    }
    return shareins;
}

-(id)init{
    self = [super init];
    if (self) {
        _messageArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)getMessage:(messageModel *)message{
    //入库
    [[messagedb shareInstance] saveMsg:message];
    //入组
    [_messageArr addObject:message];
    //已接收
    
}

- (void)executeMessage:(messageModel *)message
               success:(SuccessBlock)success
                failed:(FailedBlock)failed{
    _successblock = success;
    _failblock = failed;
    
    [[getMessage shareInstance] requestWithMessage:message];
}

@end
