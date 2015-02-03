//
//  getLongText.m
//  goldpush
//
//  Created by littest on 15/2/2.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "getLongText.h"
#import "ASIFormDataRequest.h"
#import "messageHandler.h"

static getLongText * shareins = nil;

@implementation getLongText

+ (getLongText *)shareInstance{
    if (nil == shareins)
    {
        shareins = [[getLongText alloc] init];
    }
    return shareins;
}

-(void)requestWithMessageID:(NSString *)strid{
    NSString *str = [NSString stringWithFormat:@"%@Users/getContent?contentid=%@",
                     [self getTestDoMain],
                     strid];
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
        
        if ([messageHandler shareInstance].longTextSuccessblock) {
            [messageHandler shareInstance].longTextSuccessblock(responseString);
        }
        if ([messageHandler shareInstance].longTextFailblock) {
            [messageHandler shareInstance].longTextFailblock(self);
        }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (error) {
        if ([messageHandler shareInstance].longTextFailblock) {
            [messageHandler shareInstance].longTextFailblock(self);
        }
    }
}

@end
