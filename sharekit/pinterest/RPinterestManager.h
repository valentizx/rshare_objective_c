//
//  RPinterestManager.h
//  sharekit
//
//  Created by valenti on 2018/7/25.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"

NS_ASSUME_NONNULL_BEGIN
@interface RPinterestManager : RShare


+ (instancetype)shared;

- (void)connect:(RConfiguration)c;

/**
 * Pinterest 文档 https://developers.pinterest.com/docs/sdks/ios/?
 **/
- (void)sdkInitializeByAppID:(NSString*)appID appSecret:(nullable NSString*)secret;



- (void)shareImageWithURL:(NSString*)imageURL
               webpageURL:(NSString*)webpageURL
                  onBoard:(NSString*)boardName
              description:(NSString*)description
                     from:(UIViewController*)from
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
