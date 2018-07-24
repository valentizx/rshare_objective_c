//
//  RTwitterManager.h
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"
NS_ASSUME_NONNULL_BEGIN

@interface RTwitterManager : RShare

+ (instancetype)shared;
/**
 ⚠️ Swift 版本一定要引入 MapKit 和 MobileCoreService 两个框架
 
 初始化 Twitter SDK https://apps.twitter.com/
 ⚠️ Twitter SDK 将于 2018/10/31 不再更新和提供任何支持, 但是现有的 SDK 不会作废, 需自行维护以及开发 https://blog.twitter.com/developer/en_us/topics/tools/2018/discontinuing-support-for-twitter-kit-sdk.html
 @param key ConsumerKey
 @param secret ConsumerSecret
 */
- (void)sdkInitializeByConsumerKey:(NSString*)key consumerSecret:(NSString*)secret;


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;


/**
 分享 Twitter
 Twitter 内容包括链接、文本描述和图片, 三者至少有一个不为空.

 @param webpageURL 网页链接.
 @param text 文本描述.
 @param image 图片.
 @param from 当前控制器.
 @param share 分享状态回调.
 */
- (void)shareWithWebpageURL:(nullable NSString*)webpageURL
                       text:(nullable NSString*)text
                      image:(nullable UIImage*)image
                       from:(UIViewController*)from
                 completion:(nullable RShareCompletion)share;

@end
NS_ASSUME_NONNULL_END
