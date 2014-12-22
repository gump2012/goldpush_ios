//
//  pushHandler.h
//  goldpush
//
//  Created by littest on 14/12/22.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import "BaseHandler.h"

@interface pushHandler : BaseHandler

@property(nonatomic,strong) NSMutableDictionary *curPush;

+ (pushHandler *)shareInstance;

@end
