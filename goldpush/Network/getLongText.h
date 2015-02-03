//
//  getLongText.h
//  goldpush
//
//  Created by littest on 15/2/2.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "baseRequest.h"

@interface getLongText : baseRequest
+ (getLongText *)shareInstance;
-(void)requestWithMessageID:(NSString *)strid;
@end
