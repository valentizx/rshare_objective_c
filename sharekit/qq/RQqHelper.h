//
//  RQqHelper.h
//  sharekit
//
//  Created by valenti on 2018/6/22.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "RQqManager.h"

@interface RQqHelper : NSObject


// ---------------- QQ ---------------------

// 文本
- (SendMessageToQQReq*)getTextReqToQQ:(NSString*)text
                                scene:(RQQShareScene)scene;

// 图片
- (SendMessageToQQReq*)getImageReqToQQ:(UIImage*)image
                                 title:(NSString*)title
                           description:(NSString*)description
                                 scene:(RQQShareScene)scene;

// 网页
- (SendMessageToQQReq*)getWebpageReqToQQ:(NSString*)webapgeURL
                                   title:(NSString*)title
                             description:(NSString*)description
                           thumbImageData:(NSData*)thumbImageData
                                   scene:(RQQShareScene)scene;

// 视频链接
- (SendMessageToQQReq*)getVideoReqToQQWithVideoURL:(NSString*)videoURL
                                             title:(NSString*)title
                                       description:(NSString*)description
                                    thumbImageData:(NSData*)thumbImageData
                                             scene:(RQQShareScene)scene;
// 音频
- (SendMessageToQQReq*)getAudioReqToQQWithAudioStreamURL:(NSString*)audioStreamURL
                                                   title:(NSString*)title
                                             description:(NSString*)description
                                          thumbImageData:(NSData*)thumbImageData
                                              webpageURL:(NSString*)webpageURL
                                                   scene:(RQQShareScene)scene;

// ---------------- QQ 空间 ---------------------

// 文字
- (SendMessageToQQReq*)getTextReqToQZone:(NSString*)text;

// 图文
- (SendMessageToQQReq*)getImagesReqToQZone:(NSArray<UIImage*>*)images description:(NSString*)description;

// 本地视频
- (SendMessageToQQReq*)getLocalVideoReqToQZone:(NSURL*)videoAssetURL description:(NSString*)description;

@end
