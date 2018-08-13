//
//  RFacebookManager.m
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RFacebookManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "RFacebookHelper.h"
#import "RPlatform.h"

@interface RFacebookManager()<FBSDKSharingDelegate>

@property (nonatomic, copy) RShareCompletion shareCompletion;
@property (nonatomic, strong) FBSDKShareDialog* dialog;
@end

@implementation RFacebookManager

static RFacebookManager* _instance = nil;

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
   c(RShareSDKFacebook, [RRegister shared]);
}

- (void)sdkInitializeByID:(NSString *)appId secret:(NSString *)secret {
    [FBSDKSettings setAppID:appId];
}

#pragma mark - 分享逻辑 -

// 分享网页
- (void)shareWebpageWithURL:(NSString *)webpageURL
                      quote:(NSString *)quote
                    hashTag:(NSString *)hashTag
                       from:(UIViewController *)from
                       mode:(Mode)mode
                 completion:(RShareCompletion)share {
    
    
    if (mode == ShareModeNative && ![RPlatform isInstalled:RShareSDKFacebook]) {
        NSLog(@"Facebook 未安装");
        return;
    }
    
    _shareCompletion = share;
    FBSDKShareLinkContent* content = [RFacebookHelper getLinkContent:webpageURL quote:quote hashTag:hashTag];
    FBSDKShareDialog* dialog = [FBSDKShareDialog showFromViewController:from withContent:content delegate:self];
    dialog.mode = [RFacebookHelper getMode:mode];
    if ([dialog canShow]) {
        [dialog show];
    } else {
        if (_shareCompletion) {
            _shareCompletion(RShareSDKFacebook, RShareResultFailure, @"Facebook 分享失败");
        }
    }
}

// 分享照片
- (void)sharePhotos:(NSArray<UIImage *> *)photos
               from:(UIViewController *)from
         completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKFacebook]) {
        NSLog(@"Facebook 未安装");
        return;
    }
    NSAssert([photos count] <= 6, @"图片个数不能超过 6");
    FBSDKSharePhotoContent* content = [RFacebookHelper getPhotosContent:photos];
    FBSDKShareDialog* dialog = [FBSDKShareDialog showFromViewController:from withContent:content delegate:self];
    if ([dialog canShow]) {
        [dialog show];
    } else {
        if (_shareCompletion) {
            _shareCompletion(RShareSDKFacebook, RShareResultFailure, @"Facebook 分享失败");
        }
    }
}

- (void)shareVideoWithLocalURL:(NSURL *)localVideoURL from:(UIViewController *)from {
    if (![RPlatform isInstalled:RShareSDKFacebook]) {
        NSLog(@"Facebook 未安装");
        return;
    }
    FBSDKShareVideoContent* content = [RFacebookHelper getVideoContent:localVideoURL];
    FBSDKShareDialog* dialog = [FBSDKShareDialog showFromViewController:from withContent:content delegate:self];
    if ([dialog canShow]) {
        [dialog show];
    }

}

#pragma mark - 应用跳转 -

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                          options:options];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
}

#pragma mark - 其他配置 -

- (void)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     [FBSDKAppEvents activateApp];
}
#pragma mark - FBSDKShareingDelegate -

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    if (_shareCompletion) {
        _shareCompletion(RShareSDKFacebook, RShareResultCancel, nil);
    }
    
}
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    if (_shareCompletion) {
        _shareCompletion(RShareSDKFacebook, RShareResultFailure, error.localizedDescription);
    }
    
}
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    if (_shareCompletion) {
        _shareCompletion(RShareSDKFacebook, RShareResultSuccess, nil);
    }
    
}

@end
