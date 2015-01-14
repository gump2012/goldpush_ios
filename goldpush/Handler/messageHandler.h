//
//  messageHandler.h
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "BaseHandler.h"

@class messageModel;

@interface messageHandler : BaseHandler

+ (messageHandler *)shareInstance;

@property(nonatomic,strong) NSMutableArray *messageArr;

-(void)getMessage:(messageModel *)message;
- (void)executeMessage:(messageModel *)message
              success:(SuccessBlock)success
               failed:(FailedBlock)failed;
-(messageModel *)getMessageWithPush:(NSDictionary *)pushdic;

@end
