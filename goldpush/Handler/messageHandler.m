//
//  messageHandler.m
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messageHandler.h"

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

@end
