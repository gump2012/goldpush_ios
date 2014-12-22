//
//  regist.h
//  goldpush
//
//  Created by gump on 12/14/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "baseRequest.h"
@class registModel;

@interface regist : baseRequest

+ (regist *)shareInstance;

-(void)requestWithRegist:(registModel *)reg;

@end
