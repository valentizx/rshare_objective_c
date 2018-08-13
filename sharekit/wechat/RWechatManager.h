//
//  RWechatManager.h
//  sharekit
//
//  Created by valenti on 2018/6/5.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RWXTargetScene) {
    Session = 0, /** 微信会话/好友 **/
    Timeline = 1, /** 微信朋友圈 **/
    Favorite = 2, /** 微信收藏 **/
};


typedef NS_ENUM(NSUInteger, RWXMiniProgramType){
    RWXMiniProgramTypeRelease = 0,       //**< 正式版  */
    RWXMiniProgramTypeTest = 1,        //**< 开发版  */
    RWXMiniProgramTypePreview = 2,         //**< 体验版  */
};

@interface RWechatManager : RShare

+ (instancetype)shared;

- (void)connect:(RConfiguration)c;

/**
 * 初始化微信 SDK. https://open.weixin.qq.com/c
 **/
- (void)sdkInitializeByAppID:(NSString*)appID appSecret:(NSString*)secret;


/**
 分享文字.

 @param text 文本信息.
 @param scene 分享场景.
 @param share 分享结果回调.
 */
- (void)shareText:(NSString*)text
            scene:(RWXTargetScene)scene
        completion:(nullable RShareCompletion)share;


/**
 分享图片.

 @param image 图片.
 @param scene 分享场景.
 @param share 分享结果回调.
 */
- (void)shareImage:(UIImage*)image
             scene:(RWXTargetScene)scene
         completion:(nullable RShareCompletion)share;


/**
 分享网页.

 @param webpageURL 网页链接.
 @param title 标题.
 @param description 内容描述.
 @param image 缩略图.
 @param scene 分享场景.
 @param share 分享结果回调.
 */
- (void)shareWebpageWithURL:(NSString*)webpageURL
                      title:(nullable NSString*)title
                description:(nullable NSString*)description
                 thumbImage:(nullable UIImage*)image
                      scene:(RWXTargetScene)scene
                  completion:(nullable RShareCompletion)share;



/**
 分享视频.

 @param videoURL 视频链接.
 @param title 视频标题.
 @param description 视频描述.
 @param image 缩略图.
 @param scene 分享场景.
 @param share 分享结果回调.
 */
- (void)shareVideoWithURL:(NSString*)videoURL
                    title:(nullable NSString*)title
              description:(nullable NSString*)description
               thumbImage:(nullable UIImage*)image
                    scene:(RWXTargetScene)scene
                completion:(nullable RShareCompletion)share;

/**
 分享音乐.
 
 @param musicStreamURL 音频流链接.
 @param webpageURL 音频网页.
 @param title 音乐标题.
 @param description 音乐描述.
 @param image 缩略图.
 @param scene 分享场景.
 @param share 分享结果回调.
 */
- (void)shareMusicWithStreamURL:(NSString*)musicStreamURL
                     webpageURL:(NSString*)webpageURL
                          title:(nullable NSString*)title
                    description:(nullable NSString*)description
                     thumbImage:(nullable UIImage*)image
                          scene:(RWXTargetScene)scene
                      completion:(nullable RShareCompletion)share;


/**
 分享小程序.

 @param userName 小程序原始 ID.
 @param path 小程序页面路径.
 @param type 小程序类型.
 @param webpageURL 小程序网页.
 @param title 小程序标题.
 @param description 小程序描述.
 @param image 缩略图.
 @param scene 分享场景.
 @param share 分享结果回调.
 */
- (void)shareMiniProgramWithUserName:(NSString*)userName
                                path:(NSString*)path
                                type:(RWXMiniProgramType)type
                          webpageURL:(NSString*)webpageURL
                               title:(nullable NSString*)title
                         description:(nullable NSString*)description
                          thumbImage:(nullable UIImage*)image
                               scene:(RWXTargetScene)scene
                           completion:(nullable RShareCompletion)share;


/**
 分享文件.
 
 @param fileData 文件数据, 不得超过 10 MB.
 @param extensionName 文件扩展名: mp3、mp4、pdf、txt ...
 @param title 对话框标题.
 @param image 缩略图 (iOS 端无用, 只显示「？」, Android 端生效也仅仅是分享方的对话框能看见).
 @param scene 分享场景.
 @param share 分享结果回调.
 */
- (void)shareFileWithData:(NSData*)fileData
                extension:(NSString*)extensionName
                    title:(NSString*)title
               thumbImage:(UIImage*)image
                    scene:(RWXTargetScene)scene
               completion:(nullable RShareCompletion)share;


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
NS_ASSUME_NONNULL_END
