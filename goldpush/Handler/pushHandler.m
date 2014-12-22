//
//  pushHandler.m
//  goldpush
//
//  Created by littest on 14/12/22.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import "pushHandler.h"

static pushHandler * shareins = nil;

@implementation pushHandler

+ (pushHandler *)shareInstance
{
    if (nil == shareins)
    {
        shareins = [[pushHandler alloc] init];
    }
    return shareins;
}

-(id)init{
    self = [super init];
    if (self) {
        self.curPush = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
