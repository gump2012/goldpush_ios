//
//  confirmStateHandler.h
//  goldpush
//
//  Created by littest on 14/12/29.
//  Copyright (c) 2014年 gump. All rights reserved.
//

#import "BaseHandler.h"
#import "stateModel.h"

@interface confirmStateHandler : BaseHandler

+ (confirmStateHandler *)shareInstance;

- (void)executeRegist:(stateModel *)state
              success:(SuccessBlock)success
               failed:(FailedBlock)failed;

@end
