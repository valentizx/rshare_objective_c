//
//  RWhatsAppManager.h
//  sharekit
//
//  Created by valenti on 2018/6/25.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"
NS_ASSUME_NONNULL_BEGIN
/**
 * WhatsApp iOS 分享和 Android 不同, iOS 只能对单一的媒体类型分享, 不能同时图文共存, 并且分享图片需要借助 Share Extension.
 */
@interface RWhatsAppManager : RShare

+ (instancetype)shared;

- (void)connect:(RConfiguration)c;

- (void)shareText:(NSString*)text;

- (void)shareImage:(UIImage*)image from:(UIViewController*)from;


@end
NS_ASSUME_NONNULL_END
