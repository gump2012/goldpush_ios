//
//  registHandler.m
//  goldpush
//
//  Created by gump on 12/14/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "registHandler.h"
#import "regist.h"

static registHandler * shareins = nil;

@implementation registHandler

@synthesize successblock = _successblock;
@synthesize failblock = _failblock;

+ (registHandler *)shareInstance
{
    if (nil == shareins)
    {
        shareins = [[registHandler alloc] init];
    }
    return shareins;
}

- (void)executeRegist:(registModel *)regis
              success:(SuccessBlock)success
               failed:(FailedBlock)failed
{
    _successblock = success;
    _failblock = failed;
    [[regist shareInstance] requestWithRegist:regis];
}

@end
