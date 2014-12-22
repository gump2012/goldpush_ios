//
//  myStorage.m
//  goldpush
//
//  Created by littest on 14/12/22.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import "myStorage.h"

static myStorage * shareins = nil;

@implementation myStorage

+ (myStorage *)shareInstance
{
    if (nil == shareins)
    {
        shareins = [[myStorage alloc] init];
    }
    return shareins;
}

-(void)saveUserID:(NSString *)struid{
    [[NSUserDefaults standardUserDefaults] setObject:struid forKey:@"userid"];
}

-(NSString *)getUserID{
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
    return str;
}

@end
