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
#import "RPinterestManager.h"
#import "RShareManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[RShareManager shared] application:application didFinishLaunchingWithOptions:launchOptions];
    
    RPlatform* p = [RPlatform make:^(PlatformBuilder *builder) {
        [builder add:RShareSDKPinterest];
        [builder add:RShareSDKWhatsApp];
        [builder add:RShareSDKWechat];
        [builder add:RShareSDKSina];
        [builder add:RShareSDKQQ];
        [builder add:RShareSDKTumblr];
        [builder add:RShareSDKFacebook];
        [builder add:RShareSDKTwitter];
        [builder add:RShareSDKLine];
        [builder add:RShareSDKGooglePlus];
        [builder add:RShareSDKInstagram];
    }];
    
    [[RShareManager shared] registerPlatforms:p onConfiguration:^(RShareSDKPlatform platform, RRegister *obj) {
        switch (platform) {
            case RShareSDKPinterest:
                [obj connectPinterestByAppID:@"4979706154532747851" appSecret: nil];
                break;
            case RShareSDKQQ:
                [obj connectQQByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
                break;
                
            case RShareSDKSina:
                [obj connectSinaWeiboByAppKey:@"3026908911" appSecret:@"91fbafc7be7510c0ac5d73883c655db1"];
                break;
            case RShareSDKWechat:
                [obj connectWechatByAppID:@"wxd471bcf3a21c7c4a" appSecret:@"f71570ef272a5a6699decb264be9cdbb"];
                break;
            case RShareSDKTumblr:
                [obj conncetTumblrByConsumerKey:@"ZJIv7SNrKMcct5tdQy7rzzsv3b0pTxBNYWkV548LgbIDIwsnPt" consumerSecret:@"7jsraXodsVSeMHMLtHg5FYyporapRTf2ahJFK2tsnV4x0fYjse"];
                break;
            case RShareSDKFacebook:
                [obj connectFacebookByID:@"234270717151331" secret:nil];
                break;
            case RShareSDKTwitter:
                [obj connectTwitterByConsumerKey:@"cA72pVIFxOOWWfT8t9sFLcNUS" consumerSecret:@"Rc9ornOaSWTFYqFzxDIEtIcsaWoxRcVGJs6U71kAjhHcGHyEZi"];
                
            default:
                break;
        }
    }];
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 推特测试
    //return [[RTwitterManager shared] application:app openURL:url options:options];
    // 微信测试
    //return [[RWechatManager shared] application:app openURL:url options:options];
    // 新浪测试
    // return [[RSinaWeiboManager shared] application:app openURL:url options:options];
    
    // QQ 测试
    // return [[RQqManager shared] application:app openURL:url options:nil];
    // Pinterest 测试
    

    return [[RShareManager shared]application:app openURL:url options:options];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // [[RFacebookManager shared]applicationDidBecomeActive:application];

    [[RShareManager shared] applicationDidBecomeActive:application];
}



@end

