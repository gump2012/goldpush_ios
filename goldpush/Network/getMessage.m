//
//  getMessage.m
//  goldpush
//
//  Created by littest on 15/1/14.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "getMessage.h"
#import "messageModel.h"
#import "ASIFormDataRequest.h"
#import "messageHandler.h"

static getMessage * shareins = nil;

@implementation getMessage

+ (getMessage *)shareInstance{
    if (nil == shareins)
    {
        shareins = [[getMessage alloc] init];
    }
    return shareins;
}

-(void)requestWithMessage:(messageModel *)message{
    NSString *str = [NSString stringWithFormat:@"%@receivemsg?mid=%@&phone=%@&message=%@\
&state=1&device=ios",
                     [self getPushDoMain],
                     message.mid,
                     message.deviceid,
                     message.message];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@receivemsg?mid=%@&phone=%@&message=%@&state=1&device=ios",
[self getPushDoMain],
message.mid,
message.deviceid,
message.message]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

#pragma mark ----------http delegate----------------
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    if ([responseString isEqualToString:@"success"]) {
        if ([messageHandler shareInstance].successblock) {
            [messageHandler shareInstance].successblock(self);
        }
    }else{
        if ([messageHandler shareInstance].failblock) {
            [messageHandler shareInstance].failblock(self);
        }
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (error) {
        if ([messageHandler shareInstance].failblock) {
            [messageHandler shareInstance].failblock(self);
        }
    }
}

@end
