//
//  RFacebookManager.h
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"

NS_ASSUME_NONNULL_BEGIN

@interface RFacebookManager : RShare

+ (instancetype)shared;

/**

 初始化 Facebook SDK https://developers.facebook.com/apps
 @param appId Facebook ID
 @param secret Facebook AppSecret
 */
- (void)sdkInitializeByID:(NSString*)appId secret:(nullable NSString*)secret;

/**
 分享网页.
 经测试, 在跳转原生应用分享网页的时候, 引文和话题同时存在, 只能显示话题不能显示引文, 安卓只能显示引文不能显示话题.

 @param webpageURL 链接.
 @param quote 引文和描述.
 @param hashTag 话题, 形如 “#HelloWorld”, 不能有任何符号.
 @param from 当前控制器.
 @param mode 分享模式.
 @param share 分享状态回调.
 */
- (void)shareWebpageWithURL:(NSString*)webpageURL
                      quote:(nullable NSString*)quote
                    hashTag:(nullable NSString*)hashTag
                       from:(UIViewController*)from
                       mode:(Mode)mode
                 completion:(nullable share)share;

/**
 分享照片.

 @note 偶尔有个别图片无法加载的情况, 如数组中 5 张图片, 跳转 Facebook 客户端后只成功加载了 4 张.
 
 @param photos UIImage 的照片数组, 照片必须小于 12MB, 并且用户需要安装版本 7.0 或以上的原生 iOS 版 Facebook 应用.
 @param from 当前控制器.
 @param share 分享状态回调 (无效: 跳转 Facebook 原生应用的分享回调都无效).
 */
- (void)sharePhotos:(NSArray<UIImage*>*)photos
               from:(UIViewController*)from
         completion:(nullable share)share;


/**
 分享视频.

 @param localVideoURL 本地视频 URL.
 @param from 当前控制器.
 */
- (void)shareVideoWithLocalURL:(NSURL*)localVideoURL from:(UIViewController*)from;


/**
 配置 Facebook SDK.
 
 @param application application
 @param launchOptions launch options
 */
- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 配置 Facebook SDK 有查看有多少用户激活的需求需要实现这个方法
 
 @param application application
 */
- (void)applicationDidBecomeActive:(UIApplication *)application;

- (BOOL)application:(UIApplication *)application
                openURL:(NSURL *)url
      sourceApplication:(NSString *)sourceApplication
             annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
NS_ASSUME_NONNULL_END
