//
//  messagedb.h
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import <Foundation/Foundation.h>

@class messageModel;

@interface messagedb : NSObject

+ (messagedb *)shareInstance;
-(void)creatDB;
-(void)initData;
-(BOOL)saveMsg:(messageModel *)message;
-(BOOL)updateMsg:(messageModel *)message;
-(void)deleteMsg:(messageModel *)message;
-(void)alterDB;
-(NSMutableArray *)getMessageArrFromDB;
-(void)deleteMsgWithAddressor:(NSString *)str;

@end
