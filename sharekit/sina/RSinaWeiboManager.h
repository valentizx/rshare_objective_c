//
//  RSinaWeiboManager.h
//  sharekit
//
//  Created by valenti on 2018/6/6.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * https://github.com/sinaweibosdk/weibo_ios_sdk
 **/
@interface RSinaWeiboManager : RShare

+ (instancetype)shared;


/**
 * 初始化微博 SDK. http://open.weibo.com/wiki/Sdk/ios
 **/
- (void)sdkInitializeByAppKey:(NSString*)key appSecret:(NSString*)secret;


/**
 分享文字.

 @param text 博文内容.
 @param share 分享回调.
 */
- (void)shareText:(NSString*)text completion:(nullable share)share;


/**
 分享图片.

 @warning 开启「分享到微博故事」功能图片只能传一张; 多张图片分享的情况下「分享到微博故事」的功能必须关闭!⚠️

 @param text 博文. 在开启「分享到微博故事」的功能下失效.
 @param images UIImage 格式的图片数组, 单张图片不能超过 10 MB, 最多 9 张图片.
 @param isToStory 是否分享到「微博故事」.
 @param share 分享回调.
 */
- (void)shareImage:(NSArray<UIImage*>*)images
              text:(nullable NSString*)text
           toStory:(BOOL)isToStory
         completion:(nullable share)share;



/**
 分享本地视频.
 @warning 网络视频链接可通过网页的形式分享.

 @param localVideoURL 视频 URL.
 @param text 博文. 在开启「分享到微博故事」的功能下失效.
 @param isToStory 是否分享到「微博故事」.
 @param share 分享回调.
 */
- (void)shareVideoWithLocalURL:(NSURL*)localVideoURL
                           text:(nullable NSString*)text
                        toStory:(BOOL)isToStory
                      completion:(nullable share)share;



/**
 分享网页.

 @param webpageURL 网页链接.
 @param objectID 多媒体对象 ID.
 @param title 网页标题.
 @param description 网页内容描述.
 @param image 缩略图, 不能大于 32 KB.
 @param share 分享回调.
 */
- (void)shareWebpageWithURL:(NSString*)webpageURL
                   objectID:(NSString*)objectID
                      title:(nullable NSString*)title
                description:(nullable NSString*)description
                 thumbImage:(nullable UIImage*)image
                   completion:(nullable share)share;


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
NS_ASSUME_NONNULL_END
