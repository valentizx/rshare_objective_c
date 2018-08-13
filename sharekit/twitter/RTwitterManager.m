//
//  RTwitterManager.m
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RTwitterManager.h"
#import <TwitterKit/TWTRKit.h>
#import <RTwitterAuthHelper.h>
#import "RPlatform.h"

@interface RTwitterManager()

@property (nonatomic, strong) RTwitterAuthHelper* helper;

@end


@implementation RTwitterManager

static RTwitterManager* _instance = nil;

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

- (void)connect:(RConfiguration)c {
    c(RShareSDKTwitter, [RRegister shared]);
}

- (RTwitterAuthHelper *)helper {
    if (!_helper) {
        _helper = [RTwitterAuthHelper shared];
    }
    return _helper;
}

#pragma mark - 分享逻辑 -

- (void)shareWithWebpageURL:(NSString *)webpageURL
                       text:(NSString *)text
                      image:(UIImage *)image
                       from:(UIViewController *)from
                 completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKTwitter]) {
        NSLog(@"Twitter 未安装");
        return;
    }
    NSAssert(webpageURL || text || image, @"网页、文本描述以及图片不能三者同时为空");
    if ([[RTwitterAuthHelper shared] hasLogged]) {
        TWTRComposer* composer = [[TWTRComposer alloc]init];
        [composer setURL:[NSURL URLWithString:webpageURL]];
        [composer setImage:image];
        [composer setText:text];
        [composer showFromViewController:from completion:^(TWTRComposerResult result) {
            if (share) {
                if (result == TWTRComposerResultDone) {
                    share(RShareSDKTwitter, RShareResultSuccess, nil);
                } else {
                    share(RShareSDKTwitter, RShareResultCancel, nil);
                }
            }
        }];
    } else {
        [[RTwitterAuthHelper shared]authorizeTwitter:^(RTWAuthState state, NSString * _Nullable errorInfo) {
            if (state == RTWAuthFailure) {
                if (share) {
                    share(RShareSDKTwitter, RShareResultFailure, @"用户授权失败");
                }
            } else {
                TWTRComposer* composer = [[TWTRComposer alloc]init];
                [composer setURL:[NSURL URLWithString:webpageURL]];
                [composer setImage:image];
                [composer setText:text];
                [composer showFromViewController:from completion:^(TWTRComposerResult result) {
                    if (share) {
                        if (result == TWTRComposerResultDone) {
                            share(RShareSDKTwitter, RShareResultSuccess, nil);
                        } else {
                            share(RShareSDKTwitter, RShareResultCancel, nil);
                        }
                    }
                }];
            }
        }];
    }
}

#pragma mark - 初始化配置 -
- (void)sdkInitializeByConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {
    [[Twitter sharedInstance] startWithConsumerKey:key consumerSecret:secret];
    
}


#pragma mark - 应用跳转(Twitter 授权回跳应用会调用) -
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[RTwitterAuthHelper shared]application:application openURL:url options:options];
    
}

@end
