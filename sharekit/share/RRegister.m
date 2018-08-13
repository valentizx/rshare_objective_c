//
//  RRegister.m
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RRegister.h"
#import "RFacebookManager.h"
#import "RSinaWeiboManager.h"
#import "RTwitterManager.h"
#import "RTumblrManager.h"
#import "RWechatManager.h"
#import "RPinterestManager.h"
#import "RQqManager.h"

@implementation RRegister

static RRegister* _instance = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


- (void)connectFacebookByID:(NSString *)appID secret:(NSString *)secret {
    [[RFacebookManager shared] sdkInitializeByID:appID secret:secret];
}

- (void)connectSinaWeiboByAppKey:(NSString *)key appSecret:(NSString *)secret {
    [[RSinaWeiboManager shared] sdkInitializeByAppKey:key appSecret:secret];
}

- (void)connectTwitterByConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    [[RTwitterManager shared] sdkInitializeByConsumerKey:key consumerSecret:secret];
}

- (void)conncetTumblrByConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    [[RTumblrManager shared] sdkInitializeByConsumerKey:key consumerSecret:secret];
}

- (void)connectWechatByAppID:(NSString *)appID appSecret:(NSString *)secret {
    [[RWechatManager shared] sdkInitializeByAppID:appID appSecret:secret];
}

- (void)connectPinterestByAppID:(NSString *)appID appSecret:(NSString *)secret {
    [[RPinterestManager shared] sdkInitializeByAppID:appID appSecret:secret];
}

- (void)connectQQByAppID:(NSString *)appID appKey:(NSString *)key {
    [[RQqManager shared] sdkInitializeByAppID:appID appKey:key];
}

@end
