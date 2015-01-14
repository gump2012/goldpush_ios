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
#import "messageModel.h"

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
    [self executeMessage:message success:^(id obj) {
        NSLog(@"getMessage success");
    } failed:^(id obj) {
        NSLog(@"getMessage faile");
    }];
}

- (void)executeMessage:(messageModel *)message
               success:(SuccessBlock)success
                failed:(FailedBlock)failed{
    _successblock = success;
    _failblock = failed;
    
    [[getMessage shareInstance] requestWithMessage:message];
}

-(messageModel *)getMessageWithPush:(NSDictionary *)pushdic{
    messageModel *message = [[messageModel alloc] init];
    
    NSDictionary *apsdic = [pushdic objectForKey:@"aps"];
    if (apsdic) {
        NSString *stralert = [apsdic objectForKey:@"alert"];
        if (stralert) {
            message.message = stralert;
        }
    }
    
    NSString *strmid = [pushdic objectForKey:@"mid"];
    if (strmid) {
        message.mid = strmid;
    }
    
    message.deviceid = [[myStorage shareInstance] getUserID];
    message.state = 0;
    
    return message;
}

@end
