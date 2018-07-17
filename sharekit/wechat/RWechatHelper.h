//
//  RWechatHelper.h
//  sharekit
//
//  Created by valenti on 2018/6/5.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"
#import <RWechatManager.h>

@interface RWechatHelper : NSObject

- (instancetype) init;

- (SendMessageToWXReq*)getTextMessageReqWithText:(NSString*)text scene:(RWXTargetScene)scene;

- (SendMessageToWXReq*)getImageMessageReqWithImage:(UIImage*)image scene:(RWXTargetScene)scene;

- (SendMessageToWXReq*)getWebpageMessageReqWithURL:(NSString*)webpageURL
                                             title:(NSString*)title
                                       description:(NSString*)description
                                        thumbImage:(UIImage*)image
                                             scene:(RWXTargetScene)scene;

- (SendMessageToWXReq*)getVideoMessageReqWithURL:(NSString*)videoURL
                                           title:(NSString*)title
                                     description:(NSString*)description
                                      thumbImage:(UIImage*)image
                                           scene:(RWXTargetScene)scene;

- (SendMessageToWXReq*)getMusicMessageReqWithURL:(NSString*)musicURL
                                      webpageURL:(NSString*)webpageURL
                                           title:(NSString*)title
                                     description:(NSString*)description
                                      thumbImage:(UIImage*)image
                                           scene:(RWXTargetScene)scene;

- (SendMessageToWXReq*)getMiniProgramMessageWithUserName:(NSString *)userName
                                                    path:(NSString *)path
                                                    type:(RWXMiniProgramType)type
                                              webpageURL:(NSString *)webpageURL
                                                   title:(NSString *)title
                                             description:(NSString *)description
                                              thumbImage:(UIImage *)image
                                                   scene:(RWXTargetScene)scene;
- (SendMessageToWXReq*)getFileMessageReqWithData:(NSData*)fileData
                                   extentionName:(NSString*)extensionName
                                           title:(NSString*)title
                                      thumbImage:(UIImage*)image
                                           scene:(RWXTargetScene)scene;



@end
