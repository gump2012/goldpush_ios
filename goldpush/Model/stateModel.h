//
//  stateModel.h
//  goldpush
//
//  Created by littest on 14/12/29.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stateModel : NSObject
{
    NSString * _struid;
    NSString * _strmid;
    NSString * _strstate;
}

@property(nonatomic,strong) NSString * struid;
@property(nonatomic,strong) NSString * strmid;
@property(nonatomic,strong) NSString * strstate;
@end
