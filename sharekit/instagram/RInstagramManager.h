//
//  RInstagramManager.h
//  sharekit
//
//  Created by valenti on 2018/6/1.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"
NS_ASSUME_NONNULL_BEGIN

@interface RInstagramManager : RShare
/**
 * Instagram  https://www.instagram.com/developer/mobile-sharing/iphone-hooks/
 **/
+ (instancetype)shared;

/**
 分享图片
 Instagram 无法进行多媒体分享, 只能进行单一的图片分享.

 @param image 图片.
 @param mode 分两种模式: 一种是凭借 Document Interaction 调用 UIDocumentInteractionController 分享; 另一种是直接启动 Instagram 客户端的选择图片界面.
 @param from 当前控制器.
 */
- (void)share:(UIImage *)image mode:(Mode)mode from:(UIViewController*)from;


- (void)shareVideoWithLocalURL:(NSURL*)localeVideoURL
                    description:(NSString*)description
                           from:(UIViewController*)from;

@end

NS_ASSUME_NONNULL_END
