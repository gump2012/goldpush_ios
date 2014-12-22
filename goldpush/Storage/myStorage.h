//
//  myStorage.h
//  goldpush
//
//  Created by littest on 14/12/22.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myStorage : NSObject

+ (myStorage *)shareInstance;

-(void)saveUserID:(NSString *)struid;
-(NSString *)getUserID;

@end
