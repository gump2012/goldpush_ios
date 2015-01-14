//
//  baseRequest.m
//  todayios
//
//  Created by lishiming on 14-7-21.
//  Copyright (c) 2014年 lishiming. All rights reserved.
//

#import "baseRequest.h"

@implementation baseRequest

-(id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(void)request{
    
}

-(NSString *)getDefaultValue{
    NSString *str = [NSString stringWithFormat:
                     @"&platform=ios&vc=1&vn=1.0.0&channel=appstore&sw=320&sh=480&alias=jrtp"];
    
    return str;
}

-(NSString *)getDoMain{
    NSString *str = [NSString stringWithFormat:@"%@",MAIN_DOMAIN];
    return str;
}

-(NSString *)getTestDoMain{
    NSString *str = [NSString stringWithFormat:@"%@",TEXT_DOMAIN];
    return str;
}

-(NSString *)getPushDoMain{
    NSString *str = [NSString stringWithFormat:@"%@",PUSH_DOMAIN];
    return str;
}

@end
