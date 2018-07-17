//
//  AppDelegate.m
//  share
//
//  Created by valenti on 2018/5/9.
//  Copyright © 2018 rex. All rights reserved.
//

#import "AppDelegate.h"
#import "RFacebookManager.h"
#import "RTwitterManager.h"
#import "RWechatManager.h"
#import "RSinaWeiboManager.h"
#import "RQqManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//H9XMNB7YR3BGZXZ745ZD
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[RFacebookManager shared] application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 推特测试
    //return [[RTwitterManager shared] application:app openURL:url options:options];
    // 微信测试
    //return [[RWechatManager shared] application:app openURL:url options:options];
    // 新浪测试
    // return [[RSinaWeiboManager shared] application:app openURL:url options:options];
    
    // QQ测试
    return [[RQqManager shared] application:app openURL:url options:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[RFacebookManager shared]applicationDidBecomeActive:application];
}



@end
