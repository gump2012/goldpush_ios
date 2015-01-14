//
//  getLastMessage.h
//  goldpush
//
//  Created by littest on 15/1/14.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "baseRequest.h"

@interface getLastMessage : baseRequest
+ (getLastMessage *)shareInstance;
-(void)requestWithCount:(int)icount withUID:(NSString *)strid;
@end
