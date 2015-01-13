//
//  messageHandler.h
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "BaseHandler.h"

@interface messageHandler : BaseHandler

+ (messageHandler *)shareInstance;

@property(nonatomic,strong) NSMutableArray *messageArr;

@end
