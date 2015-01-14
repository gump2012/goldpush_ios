//
//  getLastMessage.m
//  goldpush
//
//  Created by littest on 15/1/14.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "getLastMessage.h"
#import "ASIFormDataRequest.h"
#import "messageHandler.h"
#import "JSONKit.h"

static getLastMessage * shareins = nil;

@implementation getLastMessage

+ (getLastMessage *)shareInstance{
    if (nil == shareins)
    {
        shareins = [[getLastMessage alloc] init];
    }
    return shareins;
}

-(void)requestWithCount:(int)icount withUID:(NSString *)strid{
    NSString *str = [NSString stringWithFormat:@"%@Users/getLastNotice?userid=%@&msgCount=%d",
                     [self getTestDoMain],
                     strid,
                     icount];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

#pragma mark ----------http delegate----------------
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    [[messageHandler shareInstance].lastMsgArr removeAllObjects];
    NSArray *arr = [responseString objectFromJSONString];
    if ([arr isKindOfClass:[NSArray class]]) {
        [[messageHandler shareInstance].lastMsgArr setArray:arr];
        
        if ([messageHandler shareInstance].lastMsgSuccessblock) {
            [messageHandler shareInstance].lastMsgSuccessblock(self);
        }
    }
    else{
        if ([messageHandler shareInstance].lastMsgFailblock) {
            [messageHandler shareInstance].lastMsgFailblock(self);
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (error) {
        if ([messageHandler shareInstance].lastMsgFailblock) {
            [messageHandler shareInstance].lastMsgFailblock(self);
        }
    }
}

@end
