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
#import "getLastMessage.h"
#import "getLongText.h"

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
        _lastMsgArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)getMessage:(messageModel *)message{
    //入库才能入组
    if ([[messagedb shareInstance] saveMsg:message]) {
        [_messageArr addObject:message];
    }
    
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
    
    strmid = [pushdic objectForKey:@"addressor"];
    if (strmid) {
        message.addressor = strmid;
    }
    
    strmid = [pushdic objectForKey:@"truncate"];
    if (strmid) {
        message.truncate = [strmid intValue];
    }
    
    strmid = [pushdic objectForKey:@"rank"];
    if (strmid) {
        message.rank = [strmid intValue];
    }
    
    message.deviceid = [[myStorage shareInstance] getUserID];
    message.state = 0;
    
    return message;
}

-(void)getNewMessage{
    __block messageHandler *blockSelf = self;
    _lastMsgSuccessblock = ^(id a){
        NSLog(@"getNewMessage success");
        for (int i = 0; i < blockSelf.lastMsgArr.count; ++i) {
            NSDictionary *dic = blockSelf.lastMsgArr[i];
            if (dic) {
                messageModel *message = [[messageModel alloc] init];
                NSString *str = [dic objectForKey:@"content"];
                if (str) {
                    message.message = str;
                }
                str = [dic objectForKey:@"id"];
                if (str) {
                    message.mid = str;
                }
                
                str = [dic objectForKey:@"truncate"];
                if(str){
                    message.truncate = [str intValue];
                }
                
                str = [dic objectForKey:@"rank"];
                if (str) {
                    message.rank = [str intValue];
                }
                
                str = [dic objectForKey:@"addressor"];
                if (str) {
                    message.addressor = str;
                }
                
                message.deviceid = [[myStorage shareInstance] getUserID];
                message.state = 0;
                
                [blockSelf getMessage:message];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_GETLASTMSG
                                                            object:blockSelf];
    };
    
    _lastMsgFailblock = ^(id a){
        NSLog(@"getNewMessage fail");
    };
    
    [[getLastMessage shareInstance] requestWithCount:10 withUID:[[myStorage shareInstance] getUserID]];
}

-(void)updateMessageWithMsg{
    if (self.sureMsg) {
        self.sureMsg.state = 1;
        [[messagedb shareInstance] updateMsg:self.sureMsg];
        
        for (int i = 0; i < _messageArr.count; ++i) {
            messageModel *msg = [_messageArr objectAtIndex:i];
            if (msg.mid == self.sureMsg.mid) {
                msg.state = 1;
                break;
            }
        }
    }
}

-(void)executeGetLongText:(NSString *)mid
                  success:(SuccessBlock)successblock
                   failed:(FailedBlock)failed{
    _longTextSuccessblock = successblock;
    _longTextFailblock = failed;
    [[getLongText shareInstance] requestWithMessageID:mid];
}

@end
