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

-(void)setDefaultValue{
    NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys: @"", @"userid",
                                   [NSNumber numberWithBool:NO],@"registstate",
                                   [NSNumber numberWithBool:NO],@"rememberps",
                                   [NSNumber numberWithBool:NO],@"autologin",
                                   @"", @"username",
                                   @"",@"userps",
                                   nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

-(void)saveUserID:(NSString *)struid{
    [[NSUserDefaults standardUserDefaults] setObject:struid forKey:@"userid"];
}

-(NSString *)getUserID{
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"userid"];
    return str;
}

-(void)setRegitsStates:(BOOL)bSuccess{
    [[NSUserDefaults standardUserDefaults] setBool:bSuccess forKey:@"registstate"];
}

-(BOOL)registStates{
    BOOL bsuccess = [[NSUserDefaults standardUserDefaults] boolForKey:@"registstate"];
    return bsuccess;
}

-(void)setRememberPS:(BOOL)bRemember{
    [[NSUserDefaults standardUserDefaults] setBool:bRemember forKey:@"rememberps"];
}

-(BOOL)rememberPS{
    BOOL bsuccess = [[NSUserDefaults standardUserDefaults] boolForKey:@"rememberps"];
    return bsuccess;
}

-(void)setAutoLogin:(BOOL)bauto{
     [[NSUserDefaults standardUserDefaults] setBool:bauto forKey:@"autologin"];
}

-(BOOL)autoLogin{
    BOOL bsuccess = [[NSUserDefaults standardUserDefaults] boolForKey:@"autologin"];
    return bsuccess;
}

-(void)setUserName:(NSString *)strname{
    [[NSUserDefaults standardUserDefaults] setObject:strname forKey:@"username"];
}
-(NSString *)userName{
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    return str;
}

-(void)setUserPassword:(NSString *)strps{
     [[NSUserDefaults standardUserDefaults] setObject:strps forKey:@"userps"];
}
-(NSString *)userPassword{
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"userps"];
    return str;
}

@end
