//
//  RGooglePlusManager.h
//  share
//
//  Created by valenti on 2018/6/22.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"
NS_ASSUME_NONNULL_BEGIN
/**
 * Google + https://developers.google.com/+/mobile/ios/share/basic-share
 */
@interface RGooglePlusManager : RShare


+ (instancetype)shared;

- (void)connect:(RConfiguration)c;


/**
 分享链接到 Google +.
 
 @note 只能通过浏览器分享, 并且不可以加 ‘description’ 和 Android 有很大区别.

 @param url 链接.
 @param from 当前控制器.
 */
- (void)shareURL:(NSURL*)url from:(UIViewController*)from;
@end
NS_ASSUME_NONNULL_END
