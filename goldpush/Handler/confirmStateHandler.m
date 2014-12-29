//
//  confirmStateHandler.m
//  goldpush
//
//  Created by littest on 14/12/29.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import "confirmStateHandler.h"
#import "confirmState.h"

static confirmStateHandler * shareins = nil;

@implementation confirmStateHandler

+ (confirmStateHandler *)shareInstance
{
    if (nil == shareins)
    {
        shareins = [[confirmStateHandler alloc] init];
    }
    return shareins;
}

- (void)executeRegist:(stateModel *)state
              success:(SuccessBlock)success
               failed:(FailedBlock)failed{
    _successblock = success;
    _failblock = failed;
    
    [[confirmState shareInstance] requestByUserid:state.struid withMessageID:state.strmid withState:state.strstate];
}

@end
