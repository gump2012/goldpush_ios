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
        message.addressor  = [rs stringForColumn:@"addressor"];
        message.truncate = [rs intForColumn:@"truncate"];
        message.rank = [rs intForColumn:@"rank"];
        
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
        
        [database executeUpdate:@"UPDATE message SET message = ? ,  state = ? , deviceid = ? , truncate = ? WHERE mid = ? ",message.message,
         [NSNumber numberWithInt:message.state],
         message.deviceid,
          [NSNumber numberWithInt:message.truncate],
         message.mid];
    }
    [rs close];
    
    return isUpdate;
}

-(void)deleteMsg:(messageModel *)message{
    FMDatabase *database = [db shareInstance].mydb;
    [database executeUpdate:@"DELETE FROM message WHERE mid = ?",message.mid];
}

-(void)deleteMsgWithAddressor:(NSString *)str{
    FMDatabase *database = [db shareInstance].mydb;
    [database executeUpdate:@"DELETE FROM message WHERE addressor = ?",str];
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

-(NSMutableArray *)getMessageArrFromDB{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    FMDatabase *database = [db shareInstance].mydb;
    FMResultSet *rs=[database executeQuery:@"SELECT * FROM message"];
    [[messageHandler shareInstance].messageArr removeAllObjects];
    while ([rs next]){
        messageModel *message = [[messageModel alloc] init];
        message.mid = [rs stringForColumn:@"mid"];
        message.state = [rs intForColumn:@"state"];
        message.message = [rs stringForColumn:@"message"];
        message.deviceid = [rs stringForColumn:@"deviceid"];
        message.addressor  = [rs stringForColumn:@"addressor"];
        message.truncate = [rs intForColumn:@"truncate"];
        message.rank = [rs intForColumn:@"rank"];
        
        BOOL isadd = NO;
        for (int i = 0; i < arr.count; ++i) {
            NSDictionary *dic = [arr objectAtIndex:i];
            NSString *strname = [dic objectForKey:@"addressor"];
            if (strname) {
                if ([strname isEqualToString:message.addressor]) {
                    isadd = YES;
                    NSMutableArray *arr = [dic objectForKey:@"messagearr"];
                    if (arr) {
                        [arr addObject:message];
                    }
                    if (message.state == 1) {
                        NSNumber *unreadcount = [dic objectForKey:@"unreadcount"];
                        if (unreadcount) {
                            int icount = unreadcount.intValue + 1;
                            [dic setValue:[NSNumber numberWithInt:icount] forKey:@"unreadcount"];
                        }
                    }
                    
                    break;
                }
            }
        }
        
        if (!isadd) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:message.addressor forKey:@"addressor"];
            NSMutableArray *messagearr = [[NSMutableArray alloc] init];
            [messagearr addObject:message];
            [dic setObject:messagearr forKey:@"messagearr"];
            if (message.state == 1) {
                [dic setObject:[NSNumber numberWithInt:1] forKey:@"unreadcount"];
            }else{
                [dic setObject:[NSNumber numberWithInt:0] forKey:@"unreadcount"];
            }
            
            [arr addObject:dic];
        }
    }
    
    [rs close];
    
    return arr;
}

@end
