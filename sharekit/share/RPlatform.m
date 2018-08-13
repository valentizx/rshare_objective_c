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

#import "RQqManager.h"
#import "RGooglePlusManager.h"
#import "RSinaWeiboManager.h"
#import "RWechatManager.h"
#import "RWhatsAppManager.h"
#import "RTumblrManager.h"
#import "RFacebookManager.h"
#import "RTwitterManager.h"
#import "RLineManager.h"
#import "RPinterestManager.h"
#import "RInstagramManager.h"


#define ENUM_TO_CSTR_CASE(enumType)   case enumType: return(#enumType);
const char *cEnumStr(RShareSDKPlatform type) {
    
    switch (type) {
    
            ENUM_TO_CSTR_CASE(RShareSDKQQ)
            ENUM_TO_CSTR_CASE(RShareSDKLine)
            ENUM_TO_CSTR_CASE(RShareSDKSina)
            ENUM_TO_CSTR_CASE(RShareSDKTumblr)
            ENUM_TO_CSTR_CASE(RShareSDKFacebook)
            ENUM_TO_CSTR_CASE(RShareSDKTwitter)
            ENUM_TO_CSTR_CASE(RShareSDKWechat)
            ENUM_TO_CSTR_CASE(RShareSDKWhatsApp)
            ENUM_TO_CSTR_CASE(RShareSDKInstagram)
            ENUM_TO_CSTR_CASE(RShareSDKGooglePlus)
            ENUM_TO_CSTR_CASE(RShareSDKOther)
            ENUM_TO_CSTR_CASE(RShareSDKPinterest)
            
    }
}

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
        
    } else if (platform == RShareSDKPinterest){
        appString = @"pinterestsdk.v1://";
    } else {
        return false;
    }
    return [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:appString]];
}

+ (RPlatform *)make:(PlatformBuilderBlock)block {
    
    NSParameterAssert(block != nil);
    PlatformBuilder* builder = [[PlatformBuilder alloc]init];
    block(builder);
    return [builder build];
    
}

@end

@interface PlatformBuilder()

@property (nonatomic, copy) NSMutableArray<Class>* targets;
@property (nonatomic, copy) NSDictionary* infoDic;

@end


@implementation PlatformBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _targets = [NSMutableArray array];
        _infoDic = @{
                     @"RShareSDKQQ" : RQqManager.class,
                     @"RShareSDKLine" : RLineManager.class,
                     @"RShareSDKSina" : RSinaWeiboManager.class,
                     @"RShareSDKTumblr" : RTumblrManager.class,
                     @"RShareSDKFacebook" : RFacebookManager.class,
                     @"RShareSDKTwitter" : RTwitterManager.class,
                     @"RShareSDKWechat" : RWechatManager.class,
                     @"RShareSDKWhatsApp" : RWhatsAppManager.class,
                     @"RShareSDKInstagram" : RInstagramManager.class,
                     @"RShareSDKGooglePlus" : RGooglePlusManager.class,
                     @"RShareSDKPinterest" : RPinterestManager.class
                     };
        
    }
    return self;
}




- (instancetype)add:(RShareSDKPlatform)platform {
    
    NSString* str = [NSString stringWithCString:cEnumStr(platform) encoding:NSASCIIStringEncoding];
    [self.targets addObject:[_infoDic objectForKey:str]];
    return self;
}

- (RPlatform *)build {

    RPlatform* p = [[RPlatform alloc]init];
    [p setValue:_targets forKey:@"targets"];
    return p;
}


@end
