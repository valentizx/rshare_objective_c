//
//  RRegister.h
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRegister : NSObject

+ (instancetype)shared;

- (void)connectFacebookByID:(NSString*)appID secret:(nullable NSString*)secret;;
- (void)connectSinaWeiboByAppKey:(NSString*)key appSecret:(NSString*)secret;
- (void)connectTwitterByConsumerKey:(NSString*)key consumerSecret:(NSString*)secret;
- (void)conncetTumblrByConsumerKey:(NSString*)key consumerSecret:(NSString*)secret;
- (void)connectPinterestByAppID:(NSString*)appID appSecret:(nullable NSString*)secret;
- (void)connectQQByAppID:(NSString*)appID appKey:(NSString*)key;
- (void)connectWechatByAppID:(NSString*)appID appSecret:(NSString*)secret;

@end
