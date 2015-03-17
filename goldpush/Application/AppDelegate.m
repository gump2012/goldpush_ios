//
//  AppDelegate.m
//  goldpush
//
//  Created by gump on 11/28/14.
//  Copyright (c) 2014 gump. All rights reserved.
//

#import "AppDelegate.h"
#import "registViewControl.h"
#import "pushHandler.h"
#import "myStorage.h"
#import "MobClick.h"
#import "messageListViewController.h"
#import "messageModel.h"
#import "messageHandler.h"
#import "db.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[myStorage shareInstance] setDefaultValue];
    [MobClick startWithAppkey:@"54b4dafefd98c588a10001ce" reportPolicy:REALTIME channelId:@"test"];
    
    WINDOW_WIDTH = [UIScreen mainScreen].bounds.size.width;
    WINDOW_HIGHT = [UIScreen mainScreen].bounds.size.height;
    
    [[db shareInstance] creatdb];
    [[db shareInstance] alertDB];
    [[db shareInstance] initData];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeBadge| UIUserNotificationTypeSound | UIUserNotificationTypeAlert ;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (launchOptions) {
        NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (pushNotificationKey) {
            
            [[pushHandler shareInstance].curPush removeAllObjects];
            [[pushHandler shareInstance].curPush setDictionary:pushNotificationKey];
            
            messageModel *message = [[messageHandler shareInstance] getMessageWithPush:[pushHandler shareInstance].curPush];
            [[messageHandler shareInstance] getMessage:message];
        }
    }
    
    registViewControl *view = [[registViewControl alloc] init];
    UINavigationController *nai = [[UINavigationController alloc] initWithRootViewController:view];
    self.window.rootViewController = nai;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //[MobClick checkUpdate];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[messageHandler shareInstance] getNewMessage];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //成功注册registerUserNotificationSettings:后，回调的方法
    NSLog(@"notificationSettings:%@",notificationSettings);
}

-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{NSLog(@"我的设备ID: %@", deviceToken);
    NSString* strdeviceToken = [[[[deviceToken description]
                                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                              stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    [[myStorage shareInstance] saveUserID:strdeviceToken];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_GETUID
                                                        object:self
                                                      userInfo:@{@"name":strdeviceToken}];
    
}
-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{NSLog(@"注册失败，无法获取设备ID, 具体错误: %@", error);
    NSString *str = [NSString stringWithFormat:@"注册失败，无法获取设备ID, 具体错误: %@", error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_GETUIDFAIL
                                                        object:self];}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[pushHandler shareInstance].curPush removeAllObjects];
    [[pushHandler shareInstance].curPush setDictionary:userInfo];
    
    if (application.applicationState == UIApplicationStateActive) {
        //第二种情况 手机前台接到消息
    } else {
        //第三种情况 手机后台接到消息 点击消息进入程序
        //这里定义自己的处理方式
    }
    
    messageModel *message = [[messageHandler shareInstance] getMessageWithPush:[pushHandler shareInstance].curPush];
    [[messageHandler shareInstance] getMessage:message];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_GETPUSHWHENRUN
                                                        object:self];
}
@end
