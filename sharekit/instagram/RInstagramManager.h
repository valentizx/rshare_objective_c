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

- (void)connect:(RConfiguration)c;

/**
 分享图片
 Instagram 无法进行多媒体分享, 只能进行单一的图片分享.

 @param image 图片.
 */
- (void)share:(UIImage *)image;


- (void)shareVideoWithLocalURL:(NSURL*)localeVideoURL
                    description:(NSString*)description;

@end

NS_ASSUME_NONNULL_END
