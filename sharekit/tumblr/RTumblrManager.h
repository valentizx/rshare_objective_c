//
//  RTumblrManager.h
//  sharekit
//
//  Created by valenti on 2018/6/26.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"

NS_ASSUME_NONNULL_BEGIN
/**
 * Tumblr 文档 https://developer.yahoo.com/flurry/docs/tumblrsharing/iOS/
 *
 **/
@interface RTumblrManager : RShare

+ (instancetype)shared;


/**
 * 初始化 Tumblr SDK.
 */
- (void)sdkInitializeByConsumerKey:(NSString*)key consumerSecret:(NSString*)secret;


/**
 分享图片.
 @note 图片为主.

 @param imageURL 可以是本地也可以是网络图片的 URL.
 @param description 博文.
 @param webpageURL 附带网链.
 @param from 当前控制器.
 @param share 分享回调.
 */
- (void)shareImageWithURL:(NSString*)imageURL
              description:(nullable NSString*)description
               webpageURL:(nullable NSString*)webpageURL
                     from:(UIViewController*)from
                completion:(nullable RShareCompletion)share;

/**
 分享文字.
 @note 文字.
 
 @param text 博文.
 @param title 博文标题.
 @param webpageURL 附带网链.
 @param from 当前控制器.
 @param share 分享回调.
 */
- (void)shareText:(NSString *)text
            title:(nullable NSString *)title
       webpageURL:(nullable NSString *)webpageURL
             from:(UIViewController *)from
        completion:(nullable RShareCompletion)share;

@end
NS_ASSUME_NONNULL_END
