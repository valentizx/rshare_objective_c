//
//  RTwitterLoginHelper.h
//  sharekit
//
//  Created by valenti on 2018/5/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, RTWAuthState){
    RTWAuthSuccess,
    RTWAuthFailure
};

typedef void (^auth)(RTWAuthState state, NSString* _Nullable errorInfo);

@interface RTwitterAuthHelper : NSObject

+ (instancetype)shared;

- (BOOL)hasLogged;

- (void)authorizeTwitter:(auth)completion;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
