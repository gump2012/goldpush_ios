//
//  cartUpdate.m
//  todayios
//
//  Created by gump on 10/10/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "cartUpdate.h"
#import "ASIFormDataRequest.h"
@implementation cartUpdate

-(void)requestWithList:(NSString *)strlist withType:(NSString *)strtype{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?m=payment&a=cartUpdate%@",
                                       [self getDoMain],
                                       [self getDefaultValue]]];
    //LOG_Test(@"%@",url);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:strlist forKey:@"list"];
    [request setPostValue:strtype forKey:@"type"];
    _strtype = strtype;
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

#pragma mark ----------http delegate----------------
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    if (error) {
        
    }
}

@end
