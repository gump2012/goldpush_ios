//
//  messageModel.h
//  goldpush
//
//  Created by littest on 15/1/13.
//  Copyright (c) 2015年 gump. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface messageModel : NSObject

@property(strong,nonatomic) NSString *mid;
@property(strong,nonatomic) NSString *message;
@property(assign,nonatomic) int             state;
@property(strong,nonatomic) NSString *deviceid;

@end
