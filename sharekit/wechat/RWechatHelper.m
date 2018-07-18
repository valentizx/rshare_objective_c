//
//  RWechatHelper.m
//  sharekit
//
//  Created by valenti on 2018/6/5.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RWechatHelper.h"


@interface RWechatHelper()

@property (strong, nonatomic) WXMediaMessage* msg;
@property (strong, nonatomic) SendMessageToWXReq* req;

@end

@implementation RWechatHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        _msg = [WXMediaMessage message];
        _req = [[SendMessageToWXReq alloc]init];
    }
    return self;
}

- (int)getScene:(RWXTargetScene)scene {
    
    if (scene == Session) {
        return WXSceneSession;
    } else if (scene == Timeline) {
        return WXSceneTimeline;
    } else {
        return WXSceneFavorite;
    }
}
- (WXMiniProgramType)getMiniProgramType:(RWXMiniProgramType)type {
    if (type == RWXMiniProgramTypeRelease) {
        return WXMiniProgramTypeRelease;
    } else if (type == RWXMiniProgramTypeTest) {
        return WXMiniProgramTypeTest;
    } else {
        return WXMiniProgramTypePreview;
    }
}

- (NSString*)buildAction:(NSString*) name {
    NSDate* date = [NSDate date];
    NSString* stampString = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return [NSString stringWithFormat:@"%@%@",stampString, name];
}


/**
 * 构建文本消息请求体.
 */
- (SendMessageToWXReq* )getTextMessageReqWithText:(NSString *)text scene:(RWXTargetScene)scene {
    
    _req.bText = YES;
    _req.text = text;
    _req.scene = [self getScene:scene];
    
    return _req;
}

/**
 * 构建图片消息请求体.
 */
- (SendMessageToWXReq* )getImageMessageReqWithImage:(UIImage *)image scene:(RWXTargetScene)scene {
    
    _msg.mediaObject = [self getImgObjWithImage:image];
    _msg.messageAction = [self buildAction:@"image"];
    
    _req.bText = NO;
    _req.message = _msg;
    _req.scene = [self getScene:scene];
    
    return _req;
    
}

/**
 * 构建网页消息请求体.
 */
- (SendMessageToWXReq *)getWebpageMessageReqWithURL:(NSString *)webpageURL
                                              title:(NSString *)title
                                        description:(NSString *)description
                                         thumbImage:(UIImage *)image
                                              scene:(RWXTargetScene)scene {
    _msg.mediaObject = [self getWebObjWithURL:webpageURL];
    _msg.messageAction = [self buildAction:@"web"];;
    _msg.description = description;
    _msg.title = title;
    [_msg setThumbImage:image];
    
    _req.bText = NO;
    _req.message = _msg;
    _req.scene = [self getScene:scene];
    
    return _req;
}

/**
 * 构建视频消息请求体.
 */
- (SendMessageToWXReq *)getVideoMessageReqWithURL:(NSString *)videoURL
                                            title:(NSString *)title
                                      description:(NSString *)description
                                       thumbImage:(UIImage *)image
                                            scene:(RWXTargetScene)scene {
    _msg.mediaObject = [self getVideoObjWithURL:videoURL];
    _msg.messageAction = [self buildAction:@"video"];
    _msg.description = description;
    _msg.title = title;
    [_msg setThumbImage:image];
    
    _req.bText = NO;
    _req.message = _msg;
    _req.scene = [self getScene:scene];
    return _req;
}

/**
 * 构建音乐消息请求体.
 */
- (SendMessageToWXReq *)getMusicMessageReqWithURL:(NSString *)musicURL
                                       webpageURL:(NSString*)webpageURL
                                            title:(NSString *)title
                                      description:(NSString *)description
                                       thumbImage:(UIImage *)image
                                            scene:(RWXTargetScene)scene {
    _msg.mediaObject = [self getMusicObjWithURL:musicURL webpageURL:webpageURL];
    _msg.messageAction = [self buildAction:@"music"];
    _msg.description = description;
    _msg.title = title;
    [_msg setThumbImage:image];
    
    _req.bText = NO;
    _req.message = _msg;
    _req.scene = [self getScene:scene];
    return _req;
    
    
}

/**
 * 构建小程序消息请求体.
 */
- (SendMessageToWXReq *)getMiniProgramMessageWithUserName:(NSString *)userName
                                                     path:(NSString *)path
                                                     type:(RWXMiniProgramType)type
                                               webpageURL:(NSString *)webpageURL
                                                    title:(NSString *)title
                                              description:(NSString *)description
                                               thumbImage:(UIImage *)image
                                                    scene:(RWXTargetScene)scene {
    _msg.mediaObject = [self getMiniProgramObjWithUserName:userName path:path type:type webpageURL:webpageURL];
    _msg.messageAction = [self buildAction:@"miniprogram"];
    _msg.description = description;
    _msg.title = title;
    [_msg setThumbImage:image];
    
    _req.bText = NO;
    _req.message = _msg;
    _req.scene = [self getScene:scene];
    return _req;
}

- (SendMessageToWXReq*)getFileMessageReqWithData:(NSData*)fileData
                                   extentionName:(NSString*)extensionName
                                           title:(NSString*)title
                                      thumbImage:(UIImage*)image
                                           scene:(RWXTargetScene)scene{
    
    _msg.mediaObject = [self getFileObjWithData:fileData extensionName:extensionName];
    _msg.messageAction = [self buildAction:@"file"];
    _msg.title = title;
    [_msg setThumbImage:image];
    //[_msg setThumbData:UIImageJPEGRepresentation(image, 1)];
    
    _req.bText = NO;
    _req.message = _msg;
    _req.scene = [self getScene:scene];
    return _req;
    
}

#pragma mark - 构建分享实例 -

/**
 * 构建图片分享实例.
 */
- (WXImageObject*)getImgObjWithImage:(UIImage*)image {
    WXImageObject* obj = [WXImageObject object];
    obj.imageData = UIImagePNGRepresentation(image);
    return obj;
}

/**
 * 构建网页分享实例.
 */
- (WXWebpageObject*)getWebObjWithURL:(NSString*)webpageURL {
    WXWebpageObject* obj = [WXWebpageObject object];
    obj.webpageUrl = webpageURL;
    return obj;
}

/**
 * 构建视频分享实例.
 */
- (WXVideoObject*)getVideoObjWithURL:(NSString*)videoURL {
    
    WXVideoObject* obj = [WXVideoObject object];
    obj.videoUrl = videoURL;
    return obj;
}

/**
 * 构建音乐分享实例.
 */
- (WXMusicObject*)getMusicObjWithURL:(NSString*)musicURL webpageURL:(NSString*)webpageURL{
    WXMusicObject* obj = [WXMusicObject object];
    obj.musicDataUrl = musicURL;
    obj.musicUrl = webpageURL;
    return obj;
}
- (WXMiniProgramObject*)getMiniProgramObjWithUserName:(NSString*)userName
                                     path:(NSString*)path
                                     type:(RWXMiniProgramType)type
                               webpageURL:(NSString*)webpageURL {
    WXMiniProgramObject* obj = [WXMiniProgramObject object];
    obj.webpageUrl = webpageURL;
    obj.userName = userName;
    obj.path = path;
    obj.miniProgramType = [self getMiniProgramType:type];
    return obj;
}

- (WXFileObject*)getFileObjWithData:(NSData*)fileData
                      extensionName:(NSString*)extensionName{
    WXFileObject* obj = [WXFileObject object];
    obj.fileData = fileData;
    obj.fileExtension = extensionName;
    
    return obj;
}

@end
