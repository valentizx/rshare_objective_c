//
//  RTwitterLoginHelper.m
//  sharekit
//
//  Created by valenti on 2018/5/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RTwitterAuthHelper.h"
#import <TwitterKit/TWTRKit.h>

@implementation RTwitterAuthHelper

static RTwitterAuthHelper* _instance = nil;

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

- (BOOL)hasLogged {
    return [[Twitter sharedInstance].sessionStore hasLoggedInUsers];
}

- (void)authorizeTwitter:(auth)completion {
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        NSLog(@"Twitter 授权%@",@"===================");
        if (session && session.userID) {
            completion(RTWAuthSuccess, nil);
        } else {
            completion(RTWAuthFailure, error.localizedDescription);
        }
    }];
}
- (BOOL)application:(id)application openURL:(NSURL *)url options:(NSDictionary *)options {
    return [[Twitter sharedInstance]application:application openURL:url options:options];
}

#pragma mark - 分享逻辑 -



@end
