//
//  registModel.h
//  goldpush
//
//  Created by gump on 12/14/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface registModel : NSObject
{
    NSString *_userid;
    NSString *_phonenum;
    NSString *_ps;
}

@property(nonatomic,strong) NSString *userid;
@property(nonatomic,strong) NSString *phonenum;
@property(nonatomic,strong) NSString *ps;

@end
