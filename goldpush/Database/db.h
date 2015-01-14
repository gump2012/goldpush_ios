//
//  db.h
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface db : NSObject

+ (db *)shareInstance;

@property(nonatomic,strong) FMDatabase *mydb;

-(void)creatdb;
-(void)initData;

@end
