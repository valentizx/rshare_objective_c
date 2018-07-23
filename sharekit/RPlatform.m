//
//  RPlatform.m
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RPlatform.h"
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"

@implementation RPlatform

+ (BOOL)isInstalled:(RShareSDKPlatform)platform {
    
    
    NSString* appString;
    
    if (platform == RShareSDKWhatsApp) {
        appString = @"whatsapp://";
    } else if (platform == RShareSDKQQ) {
        return [QQApiInterface isQQInstalled];
    } else if (platform == RShareSDKWechat) {
        return [WXApi isWXAppInstalled];
    } else if (platform == RShareSDKSina) {
        return [WeiboSDK isWeiboAppInstalled];
    } else if (platform == RShareSDKInstagram) {
        appString = @"instagram://";
    } else if (platform == RShareSDKTwitter) {
        appString = @"twitter://";
    } else if (platform == RShareSDKFacebook) {
        appString = @"fbapi://";
    } else if (platform == RShareSDKLine) {
        appString = @"line://";
        
    } else {
        return false;
    }
    return [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:appString]];
}

@end
