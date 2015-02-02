//
//  db.m
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import "db.h"
#import "messagedb.h"

static db * shareins = nil;

@implementation db

+ (db *)shareInstance{
    if (nil == shareins)
    {
        shareins = [[db alloc] init];
    }
    return shareins;
}

-(id)init{
    self  = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"message.db"];
        //创建数据库实例 db  这里说明下:如果路径中不存在"Test.db"的文件,sqlite会自动创建"Test.db"
        _mydb = [FMDatabase databaseWithPath:dbPath] ;
        if (![_mydb open]) {
            NSLog(@"Could not open db.");
        }
    }
    return self;
}

-(void)creatdb{
    [[messagedb shareInstance] creatDB];
}

-(void)initData{
    [[messagedb shareInstance] initData];
}

-(void)alertDB{
    [[messagedb shareInstance] alterDB];
}

@end
