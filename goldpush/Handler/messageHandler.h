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
@property(nonatomic,copy) SuccessBlock lastMsgSuccessblock;
@property(nonatomic,copy) FailedBlock lastMsgFailblock;
@property(nonatomic,strong) NSMutableArray *lastMsgArr;
@property(nonatomic,strong) messageModel *sureMsg;
@property(nonatomic,copy) SuccessBlock longTextSuccessblock;
@property(nonatomic,copy) FailedBlock longTextFailblock;

-(void)getMessage:(messageModel *)message;
- (void)executeMessage:(messageModel *)message
              success:(SuccessBlock)success
               failed:(FailedBlock)failed;
-(messageModel *)getMessageWithPush:(NSDictionary *)pushdic;
-(void)getNewMessage;
-(void)updateMessageWithMsg;
-(void)executeGetLongText:(NSString *)mid
                  success:(SuccessBlock)successblock
                   failed:(FailedBlock)failed;
-(void)updateMessageWithMsg:(messageModel *)msg;
@end
