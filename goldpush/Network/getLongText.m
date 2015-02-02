//
//  getLongText.m
//  goldpush
//
//  Created by littest on 15/2/2.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "getLongText.h"

static getLongText * shareins = nil;

@implementation getLongText

+ (getLongText *)shareInstance{
    if (nil == shareins)
    {
        shareins = [[getLongText alloc] init];
    }
    return shareins;
}

@end
