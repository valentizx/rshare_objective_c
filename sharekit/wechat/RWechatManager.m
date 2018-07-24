//
//  RWechatManager.m
//  sharekit
//
//  Created by valenti on 2018/6/5.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RWechatManager.h"
#import "WXApi.h"
#import "RWechatHelper.h"
#import "RPlatform.h"


@interface RWechatManager()<WXApiDelegate>

@property (strong, nonatomic) RWechatHelper* helper;
@property (copy, nonatomic) RShareCompletion shareCompetion;

@end

@implementation RWechatManager

static RWechatManager* _instance = nil;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (void)sdkInitializeByAppID:(NSString *)appID appSecret:(NSString *)secret {
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_VIDEO | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    [WXApi registerApp:appID];
}

#pragma mark - 分享逻辑 -

- (void)shareText:(NSString *)text scene:(RWXTargetScene)scene completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKWechat]) {
        NSLog(@"微信未安装");
        return;
    }
    _shareCompetion = share;
    _helper = [[RWechatHelper alloc] init];
    SendMessageToWXReq* req = [_helper getTextMessageReqWithText:text scene:scene];
    [WXApi sendReq:req];
}

- (void)shareImage:(UIImage *)image scene:(RWXTargetScene)scene completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKWechat]) {
        NSLog(@"微信未安装");
        return;
    }
    _shareCompetion = share;
    _helper = [[RWechatHelper alloc] init];
    SendMessageToWXReq* req = [_helper getImageMessageReqWithImage:image scene:scene];
    [WXApi sendReq:req];
}

- (void)shareWebpageWithURL:(NSString *)webpageURL
                      title:(NSString *)title
                description:(NSString *)description
                 thumbImage:(UIImage*)image
                      scene:(RWXTargetScene)scene
                  completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKWechat]) {
        NSLog(@"微信未安装");
        return;
    }
    _shareCompetion = share;
    _helper = [[RWechatHelper alloc] init];
    SendMessageToWXReq* req = [_helper getWebpageMessageReqWithURL:webpageURL title:title description:description thumbImage:image scene:scene];
    [WXApi sendReq:req];
}

- (void)shareVideoWithURL:(NSString *)videoURL
                    title:(NSString *)title
              description:(NSString *)description
               thumbImage:(UIImage *)image
                    scene:(RWXTargetScene)scene
                completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKWechat]) {
        NSLog(@"微信未安装");
        return;
    }
    
    _shareCompetion = share;
    _helper = [[RWechatHelper alloc] init];
    SendMessageToWXReq* req = [_helper getVideoMessageReqWithURL:videoURL title:title description:description thumbImage:image scene:scene];
    [WXApi sendReq:req];
}

- (void)shareMusicWithStreamURL:(NSString *)musicStreamURL
                     webpageURL:(NSString *)webpageURL
                          title:(NSString *)title
                    description:(NSString *)description
                     thumbImage:(UIImage *)image
                          scene:(RWXTargetScene)scene
                      completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKWechat]) {
        NSLog(@"微信未安装");
        return;
    }
    
    _shareCompetion = share;
    _helper = [[RWechatHelper alloc] init];
    SendMessageToWXReq* req = [_helper getMusicMessageReqWithURL:musicStreamURL webpageURL:webpageURL title:title description:description thumbImage:image scene:scene];
    [WXApi sendReq:req];
}

- (void)shareMiniProgramWithUserName:(NSString *)userName
                                path:(NSString *)path
                                type:(RWXMiniProgramType)type
                          webpageURL:(NSString *)webpageURL
                               title:(NSString *)title
                         description:(NSString *)description
                          thumbImage:(UIImage *)image
                               scene:(RWXTargetScene)scene
                           completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKWechat]) {
        NSLog(@"微信未安装");
        return;
    }
    
    _shareCompetion = share;
    _helper = [[RWechatHelper alloc] init];
    SendMessageToWXReq* req = [_helper getMiniProgramMessageWithUserName:userName path:path type:type webpageURL:webpageURL title:title description:description thumbImage:image scene:scene];
    [WXApi sendReq:req];
}

- (void)shareFileWithData:(NSData *)fileData
                extension:(NSString *)extensionName
                    title:(NSString *)title
               thumbImage:(UIImage *)image
                    scene:(RWXTargetScene)scene
               completion:(RShareCompletion)share {
    if (![RPlatform isInstalled:RShareSDKWechat]) {
        NSLog(@"微信未安装");
        return;
    }
    _shareCompetion = share;
    _helper = [[RWechatHelper alloc]init];
    SendMessageToWXReq* req = [_helper getFileMessageReqWithData:fileData extentionName:extensionName title:title thumbImage:image scene:scene];
    [WXApi sendReq:req];
}

#pragma mark - 应用回转 -

- (BOOL)application:(UIApplication *)application
              openURL:(NSURL *)url
              options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - WXApiDeleagate -

- (void)onReq:(BaseReq *)req {}
- (void)onResp:(BaseResp *)resp {
    if (_shareCompetion != nil) {
        if (resp.errCode == 0) {
            _shareCompetion(RShareSDKWechat, RShareResultSuccess ,nil);
        } else if (resp.errCode == -2) {
            _shareCompetion(RShareSDKWechat, RShareResultCancel, nil);
        } else {
            _shareCompetion(RShareSDKWechat, RShareResultFailure, resp.errStr);
        }
    }
    
}

@end
