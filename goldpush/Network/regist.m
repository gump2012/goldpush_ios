//
//  regist.m
//  goldpush
//
//  Created by gump on 12/14/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "regist.h"
#import "ASIFormDataRequest.h"
#import "registHandler.h"

static regist * shareins = nil;

@implementation regist

+ (regist *)shareInstance{
    if (nil == shareins)
    {
        shareins = [[regist alloc] init];
    }
    return shareins;
}

-(void)requestWithRegist:(registModel *)reg{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Users/userRegistration?userid=%@&phoneNum=%@&deviceType=ios",[self getDoMain],
                                       reg.userid,
                                       reg.phonenum]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

#pragma mark ----------http delegate----------------
- (void)requestFinished:(ASIHTTPRequest *)request
{
         NSString *responseString = [request responseString];
    if ([responseString isEqualToString:@"success"]) {
        if ([registHandler shareInstance].successblock) {
            [registHandler shareInstance].successblock(self);
        }
    }else{
        if ([registHandler shareInstance].failblock) {
            [registHandler shareInstance].failblock(self);
        }
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (error) {
        if ([registHandler shareInstance].failblock) {
            [registHandler shareInstance].failblock(self);
        }
    }
}

@end
