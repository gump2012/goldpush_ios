//
//  BaseHandler.m
//  goldpush
//
//  Created by gump on 12/14/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseHandler.h"

@implementation BaseHandler

@synthesize successblock = _successblock;
@synthesize failblock = _failblock;

+ (NSString *)requestUrlWithPath:(NSString *)path{
    return @"";
}

@end
