//
//  messagedb.m
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "messagedb.h"
#import "db.h"
#import "messageModel.h"
#import "messageHandler.h"

static messagedb * shareins = nil;

@implementation messagedb

+ (messagedb *)shareInstance{
    if (nil == shareins)
    {
        shareins = [[messagedb alloc] init];
    }
    return shareins;
}

-(void)initData{
    FMDatabase *database = [db shareInstance].mydb;
    FMResultSet *rs=[database executeQuery:@"SELECT * FROM message"];
    [[messageHandler shareInstance].messageArr removeAllObjects];
    while ([rs next]){
        messageModel *message = [[messageModel alloc] init];
        message.mid = [rs stringForColumn:@"mid"];
        message.state = [rs intForColumn:@"state"];
        message.message = [rs stringForColumn:@"message"];
        message.deviceid = [rs stringForColumn:@"deviceid"];
        
        [[messageHandler shareInstance].messageArr addObject:message];
    }
    
    [rs close];
}

-(BOOL)saveMsg:(messageModel *)message{
    BOOL isSave = NO;
    FMDatabase *database = [db shareInstance].mydb;
    FMResultSet *rs = [database executeQuery:@"SELECT * FROM message WHERE mid = ?",message.mid];
    
    if (![rs next]){
        isSave  = YES;
        
        [database executeUpdate:@"INSERT INTO message (mid,state,message,deviceid,truncate,rank,addressor) VALUES (?,?,?,?,?,?,?)",message.mid,
         [NSNumber numberWithInt:message.state],
         message.message,
         message.deviceid,
         [NSNumber numberWithInt:message.truncate],
         [NSNumber numberWithInt:message.rank],
         message.addressor];
    }
    [rs close];
    
    return isSave;
}

-(BOOL)updateMsg:(messageModel *)message{
    BOOL isUpdate = NO;
    FMDatabase *database = [db shareInstance].mydb;
    FMResultSet *rs = [database executeQuery:@"SELECT * FROM message WHERE mid = ?",message.mid];
    
    if ([rs next]){
        isUpdate  = YES;
        
        [database executeUpdate:@"UPDATE message SET message = ? ,  state = ? , deviceid = ? WHERE mid = ? ",message.message,
         [NSNumber numberWithInt:message.state],
         message.deviceid,
         message.mid];
    }
    [rs close];
    
    return isUpdate;
}

-(void)deleteMsg:(messageModel *)message{
    FMDatabase *database = [db shareInstance].mydb;
    [database executeUpdate:@"DELETE FROM message WHERE mid = ?",message.mid];
}

-(void)creatDB{
     FMDatabase *database = [db shareInstance].mydb;
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS message (mid text,state integer,message text,deviceid text)"];
}

-(void)alterDB{
    FMDatabase *database = [db shareInstance].mydb;
    [database executeUpdate:@"ALTER TABLE  message ADD addressor text"];  
    [database executeUpdate:@"ALTER TABLE  message ADD rank integer(1)"];
    [database executeUpdate:@"ALTER TABLE  message ADD truncate integer(0)"];
}

@end
