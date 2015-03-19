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

-(void)setDefaultValue;

-(void)saveUserID:(NSString *)struid;
-(NSString *)getUserID;

-(void)setUserName:(NSString *)strname;
-(NSString *)userName;

-(void)setUserPassword:(NSString *)strps;
-(NSString *)userPassword;

//regist
-(void)setRegitsStates:(BOOL)bSuccess;
-(BOOL)registStates;

-(void)setRememberPS:(BOOL)bRemember;
-(BOOL)rememberPS;

-(void)setAutoLogin:(BOOL)bauto;
-(BOOL)autoLogin;
@end
