//
//  confirmState.m
//  goldpush
//
//  Created by littest on 14/12/29.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import "confirmState.h"
#import "ASIFormDataRequest.h"
#import "confirmStateHandler.h"

static confirmState * shareins = nil;

@implementation confirmState

+ (confirmState *)shareInstance{
    if (nil == shareins)
    {
        shareins = [[confirmState alloc] init];
    }
    return shareins;
}

-(void)requestByUserid:(NSString *)struid withMessageID:(NSString *)strmid withState:(NSString *)strState{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Notice/NoticeBack?userid=%@&msgid=%@&state=%@",[self getTestDoMain],
                                       struid,
                                       strmid,
                                       strState]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

#pragma mark ----------http delegate----------------
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    if ([responseString isEqualToString:@"success"]) {
        if ([confirmStateHandler shareInstance].successblock) {
            [confirmStateHandler shareInstance].successblock(self);
        }
    }else{
        if ([confirmStateHandler shareInstance].failblock) {
            [confirmStateHandler shareInstance].failblock(self);
        }
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (error) {
        if ([confirmStateHandler shareInstance].failblock) {
            [confirmStateHandler shareInstance].failblock(self);
        }
    }
}

@end
