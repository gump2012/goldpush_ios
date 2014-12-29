//
//  BaseHandler.h
//  goldpush
//
//  Created by gump on 12/14/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompleteBlock)();
typedef void (^SuccessBlock)(id obj);
typedef void (^FailedBlock)(id obj);

@interface BaseHandler : NSObject{
    SuccessBlock _successblock;
    FailedBlock _failblock;
}

@property(nonatomic,copy) SuccessBlock successblock;
@property(nonatomic,copy) FailedBlock failblock;

+ (NSString *)requestUrlWithPath:(NSString *)path; 

@end
