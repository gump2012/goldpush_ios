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
    
}

+ (registHandler *)shareInstance;

- (void)executeRegist:(registModel *)regis
                         success:(SuccessBlock)success
                          failed:(FailedBlock)failed;



@end
