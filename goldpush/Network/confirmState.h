//
//  confirmState.h
//  goldpush
//
//  Created by littest on 14/12/29.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import "baseRequest.h"

@interface confirmState : baseRequest

+ (confirmState *)shareInstance;
-(void)requestByUserid:(NSString *)struid withMessageID:(NSString *)strmid withState:(NSString *)strState;

@end
