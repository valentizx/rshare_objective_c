//
//  RQqManager.h
//  sharekit
//
//  Created by valenti on 2018/6/21.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(uint64_t, RQQShareScene) {
    RQQShareAutomatic = 0x04, /**< 普通好友列表, 默认*/
    RQQShareFavorites = 0x08, /**< 我的收藏*/
    RQQShareDataline = 0x10 /**< 我的电脑, 电脑数据线*/
};
/**
 * QQ SDK http://wiki.open.qq.com/wiki/mobile/SDK%E4%B8%8B%E8%BD%BD
 */
@interface RQqManager : RShare

+ (instancetype)shared;

- (void)connect:(RConfiguration)c;

- (void)sdkInitializeByAppID:(NSString*)appID appKey:(NSString*)key;



/**
 分享纯文字至 QQ.

 @param text 文本.
 @param scene 分享场景 (普通好友列表、我的电脑和我的收藏).
 @param share 分享回调.
 */
- (void)shareTextToQQ:(NSString*)text scene:(RQQShareScene)scene completion:(nullable RShareCompletion)share;


/**
 分享图片至 QQ.

 @note description 和 title 字段仅对发送至电脑数据线和我的收藏生效!
 @param image UIImage 格式图片.
 @param title 标题.
 @param description 描述.
 @param scene 分享场景 (普通好友列表、我的电脑和我的收藏).
 @param share 分享回调.
 */
- (void)shareImageToQQ:(UIImage*)image
                 title:(NSString*)title
           description:(nullable NSString*)description
                 scene:(RQQShareScene)scene
              completion:(nullable RShareCompletion)share;

/**
 分享网页至 QQ.

 @param webpageURL 网页链接.
 @param title 标题.
 @param description 网页描述.
 @param thumbImage 缩略图.
 @param scene 分享场景 (普通好友列表、我的电脑和我的收藏).
 @param share 分享回调.
 */
- (void)shareWebpageToQQWithURL:(NSString*)webpageURL
                          title:(NSString*)title
                    description:(nullable NSString*)description
                     thumbImage:(nullable UIImage*)thumbImage
                          scene:(RQQShareScene)scene
                       completion:(nullable RShareCompletion)share;


/**
 分享视频链接至 QQ (道理和分享网页是一样的, 并且分享视频的专属接口在 iOS 上有待完善, 在 Android 和 PC 上表现良好, 腾讯团队后续会优化).
 @note Android 上只有分享网页的接口, 没有细化到视频.

 @param videoURL 视频链接.
 @param title 标题.
 @param description 视频网页描述.
 @param thumbImage 缩略图.
 @param scene 分享场景 (普通好友列表、我的电脑和我的收藏).
 @param share 分享回调.
 */
- (void)shareVideoToQQWithURL:(NSString*)videoURL
                        title:(NSString*)title
                  description:(nullable NSString*)description
                   thumbImage:(nullable UIImage*)thumbImage
                        scene:(RQQShareScene)scene
                     completion:(nullable RShareCompletion)share;


/**
 分享音频至 QQ (道理和分享网页是一样的).

 @param audioStreamURL 音频流链接.
 @param title 标题.
 @param description 音频描述.
 @param thumbImage 对话框缩略图.
 @param webpageURL 音频网页.
 @param scene 分享场景 (普通好友列表、我的电脑和我的收藏).
 @param share 分享回调.
 */
- (void)shareAudioToQQWithStreamURL:(NSString*)audioStreamURL
                              title:(NSString*)title
                        description:(nullable NSString*)description
                         thumbImage:(nullable UIImage*)thumbImage
                         webpageURL:(nullable NSString*)webpageURL
                              scene:(RQQShareScene)scene
                           completion:(nullable RShareCompletion)share;


/**
 分享文件到 QQ (只能分享到数据线功能).

 @param fileData Data 格式文件数据.
 @param fileName 文件名.
 @param title 标题.
 @param description 文件描述.
 @param thumbImage 缩略图.
 @param share 分享回调.

 @note fileName 字段最优的设置方式是「文件名 + 扩展名」, 形如: HelloWorld.doc, 单纯的设置 Helloworld, 点开对话框文件图标显示「？」, 并且无法打开和查看, 设置好扩展名后 QQ 内置的文件解析是可以本地查看或者打开的(常见的文件测试打开正常, 较不常见的视频格式和文件格式无法打开).
 */
- (void)shareFileToQQWithFileData:(NSData*)fileData
                         fileName:(NSString*)fileName
                            title:(nullable NSString*)title
                     description :(nullable NSString*)description
                       thumbImage:(UIImage*)thumbImage
                       completion:(nullable RShareCompletion)share;


/**
 分享纯文字到 QQ 空间.

 @param text 文字内容.
 @param share 分享回调.
 */
- (void)shareTextToQZone:(NSString*)text completion:(RShareCompletion)share;


/**
 分享图片到 QQ 空间.

 @param images UIImage 格式的图片数组, SDK 支持数量在 20 张以内.
 @param description 说说正文, 但是在图片数组存在的情况下会被过滤掉, 腾讯鼓励用户自行输入文字的方式来分享说说, 若图片数组为空则会转变成纯粹的文字分享.
 @param share 分享回调.
 */
- (void)shareImagesToQZone:(NSArray<UIImage*>*)images
               description:(nullable NSString*)description
                  completion:(nullable RShareCompletion)share;


/**
 分享本地视频到 QQ 空间.

 @param videoAssetURL 本地视频 URL.
 @param description 内容失效, 腾讯鼓励用户自行输入文字的方式来分享说说.
 @param share 分享回调.
 */
- (void)shareVideoToQZoneWithAssetURL:(NSURL*)videoAssetURL
                          description:(nullable NSString*)description
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
