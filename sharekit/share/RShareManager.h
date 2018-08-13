//
//  RShareManager.h
//  sharekit
//
//  Created by valenti on 2018/6/27.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPlatform.h"
#import <UIKit/UIKit.h>
#import "RShare.h"
#import "RTextContent.h"
#import "RVideoContent.h"
#import "RImageContent.h"
#import "RWebpageContent.h"

@class RRegister;


typedef NS_ENUM(NSInteger, RShareChannel) {
    RShareChannelQQSession, // QQ 好友
    RShareChannelQQFavorite, // QQ 收藏
    RShareChannelQQDataLine, // QQ 我的电脑(数据传输)
    RShareChannelQZone, // QQ 空间
    RShareChannelWechatSession, // 微信好友
    RShareChannelWechatFavorite, // 微信收藏
    RShareChannelWechatTimeline, // 微信朋友圈
    RShareChannelFacebookClient, // Facebook 客户端
    RShareChannelFacebookBroswer, // Facebook Feed 形式网页
    RShareChannelTwitter,// 推特
    RShareChannelSinaWeibo, // 新浪微博
    RShareChannelSinaWeiboStory, // 新浪微博 - 我的故事
    RShareChannelLine, // Line
    RShareChannelInstagram, // Instagram
    RShareChannelTumblr, // Tumblr
    RShareChannelPinterest, // Pinterest
    RShareChannelGooglePlus, // GooglePlus
    RShareChannelWhatsApp // WhatsApp
};

@interface RShareManager : NSObject

+ (instancetype)shared;

- (void)registerPlatforms:(RPlatform*)p
          onConfiguration:(RConfiguration)configuration;


- (void)shareVideoWithContent:(RVideoContent*)content
                      channel:(RShareChannel)channel
                         from:(UIViewController*)from
                   completion:(RShareCompletion)completion;

- (void)shareImageWithContent:(RImageContent*)content
                      channel:(RShareChannel)channel
                         from:(UIViewController*)from
                   completion:(RShareCompletion)completion;

- (void)shareWebpageWithContent:(RWebpageContent*)content
                        channel:(RShareChannel)channel
                           from:(UIViewController*)from
                     completion:(RShareCompletion)completion;

- (void)shareTextWithContent:(RTextContent*)content
                     channel:(RShareChannel)channel
                        from:(UIViewController*)from
                  completion:(RShareCompletion)completion;


#pragma mark - 应用 -

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

- (void)applicationDidBecomeActive:(UIApplication *)application;

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end



