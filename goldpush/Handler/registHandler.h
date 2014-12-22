//
//  registHandler.h
//  goldpush
//
//  Created by gump on 12/14/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "BaseHandler.h"
#import "registModel.h"

@interface registHandler : BaseHandler
{
    SuccessBlock _successblock;
    FailedBlock _failblock;
}

+ (registHandler *)shareInstance;

- (void)executeRegist:(registModel *)regis
                         success:(SuccessBlock)success
                          failed:(FailedBlock)failed;

@property(nonatomic,copy) SuccessBlock successblock;
@property(nonatomic,copy) FailedBlock failblock;

@end
