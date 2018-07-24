//
//  RQqManager.m
//  sharekit
//
//  Created by valenti on 2018/6/21.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RQqManager.h"
#import "RQqHelper.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "RPlatform.h"


@interface RQqManager()<QQApiInterfaceDelegate, TencentSessionDelegate>


@property (nonatomic, strong) TencentOAuth* oauth;
@property (nonatomic, strong) RQqHelper* helper;
@property (nonatomic, assign) QQApiSendResultCode resultCode;
@property (nonatomic, copy) RShareCompletion share;

@end

@implementation RQqManager

static RQqManager* _instance = nil;

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


- (RQqHelper*)getQHelper {
    if (!_helper) {
        _helper = [[RQqHelper alloc]init];
    }
    return _helper;
}


- (void)sdkInitializeByAppID:(NSString *)appID appKey:(NSString *)key {
    _oauth = [[TencentOAuth alloc]initWithAppId:appID andDelegate:self];;
}

#pragma mark - 分享逻辑 -
- (void)shareTextToQQ:(NSString *)text scene:(RQQShareScene)scene completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKQQ]) {
        NSLog(@"QQ 未安装");
        return;
    }
    _share = share;
    _resultCode = [QQApiInterface sendReq:[[self getQHelper] getTextReqToQQ:text scene:scene]];
    [self handleResultCode:_resultCode];
}

- (void)shareImageToQQ:(UIImage *)image
                 title:(NSString *)title
           description:(NSString *)description
                 scene:(RQQShareScene)scene
              completion:(RShareCompletion)share {
    if (![RPlatform isInstalled:RShareSDKQQ]) {
        NSLog(@"QQ 未安装");
        return;
    }
    _share = share;
    _resultCode = [QQApiInterface sendReq:[[self getQHelper] getImageReqToQQ:image title:title description:description scene:scene]];
    [self handleResultCode:_resultCode];
}

-(void)shareWebpageToQQWithURL:(NSString *)webpageURL
                         title:(NSString *)title
                   description:(NSString *)description
                    thumbImage:(UIImage*)thumbImage
                         scene:(RQQShareScene)scene
                      completion:(RShareCompletion)share {
    if (![RPlatform isInstalled:RShareSDKQQ]) {
        NSLog(@"QQ 未安装");
        return;
    }
    _share = share;

    NSData* thumbImageData = UIImageJPEGRepresentation(thumbImage, 1.0f);
    _resultCode = [QQApiInterface sendReq:[[self getQHelper] getWebpageReqToQQ:webpageURL title:title description:description thumbImageData:thumbImageData scene:scene]];
    [self handleResultCode:_resultCode];
}

- (void)shareVideoToQQWithURL:(NSString *)videoURL
                        title:(NSString *)title
                  description:(NSString *)description
                   thumbImage:(UIImage *)thumbImage
                        scene:(RQQShareScene)scene
                     completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKQQ]) {
        NSLog(@"QQ 未安装");
        return;
    }
    
    _share = share;
    
    NSData* thumbImageData = UIImageJPEGRepresentation(thumbImage, 1.0f);
    _resultCode = [QQApiInterface sendReq:[[self getQHelper] getVideoReqToQQWithVideoURL:videoURL title:title description:description thumbImageData:thumbImageData scene:scene]];
    [self handleResultCode:_resultCode];
    
}

- (void)shareAudioToQQWithStreamURL:(NSString*)audioStreamURL
                              title:(NSString*)title
                        description:(NSString*)description
                         thumbImage:(UIImage*)thumbImage
                         webpageURL:(NSString*)webpageURL
                              scene:(RQQShareScene)scene
                           completion:(RShareCompletion)share
                              {
                                  
    if (![RPlatform isInstalled:RShareSDKQQ]) {
        NSLog(@"QQ 未安装");
        return;
    }

    _share = share;
    
    NSData* thumbImageData = UIImageJPEGRepresentation(thumbImage, 1.0f);
    _resultCode = [QQApiInterface sendReq:[[self getQHelper]getAudioReqToQQWithAudioStreamURL:audioStreamURL title:title description:description thumbImageData:thumbImageData webpageURL:webpageURL scene:scene]];
    [self handleResultCode:_resultCode];
    
}


- (void)shareTextToQZone:(NSString *)text completion:(RShareCompletion)share {
    
    
    if (![RPlatform isInstalled:RShareSDKQQ]) {
        NSLog(@"QQ 未安装");
        return;
    }
    _share = share;
    
    _resultCode = [QQApiInterface sendReq:[[self getQHelper] getTextReqToQZone:text]];
    [self handleResultCode:_resultCode];
}

- (void)shareImagesToQZone:(NSArray<UIImage *> *)images description:(NSString*)description completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKQQ]) {
        NSLog(@"QQ 未安装");
        return;
    }
    
    NSAssert(images.count <= 20, @"图片数量不能超过 20 张!");
    _share = share;
    
    _resultCode = [QQApiInterface sendReq:[[self getQHelper] getImagesReqToQZone:images description:description]];
    [self handleResultCode:_resultCode];
}

- (void)shareVideoToQZoneWithAssetURL:(NSURL *)videoAssetURL
                          description:(NSString *)description
                             completion:(RShareCompletion)share {
    
    
    if (![RPlatform isInstalled:RShareSDKQQ]) {
        NSLog(@"QQ 未安装");
        return;
    }
    _share = share;
    
    _resultCode = [QQApiInterface sendReq:[[self getQHelper] getLocalVideoReqToQZone:videoAssetURL description:description]];
    [self handleResultCode:_resultCode];
    
}

#pragma mark - 处理启动 QQ 的响应码 -

// 只处理错误的响应
- (void)handleResultCode:(QQApiSendResultCode)code {

    switch (code) {
        case EQQAPIAPPNOTREGISTED: {
            _share(RShareSDKQQ, RShareResultFailure, @"应用未注册");
            break;
        }
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        case EQQAPIMESSAGECONTENTINVALID: {
            _share(RShareSDKQQ, RShareResultFailure, @"参数错误");
            break;
        }
        case EQQAPIQQNOTINSTALLED: {
    
            _share(RShareSDKQQ, RShareResultFailure, @"应用未安装");
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI: {
            _share(RShareSDKQQ, RShareResultFailure, @"不支持的客户端");
            break;
        }
        case EQQAPISENDFAILD: {
            _share(RShareSDKQQ, RShareResultFailure, @"发送失败");
            break;
        }
        case EQQAPIVERSIONNEEDUPDATE: {
            _share(RShareSDKQQ, RShareResultFailure, @"QQ版本过低");
            break;
        }
        case EQQAPIQZONENOTSUPPORTTEXT: {
    
            _share(RShareSDKQQ, RShareResultFailure, @"QQ空间不支持的 Text 类型分享!");
            break;
        }
        case EQQAPIQZONENOTSUPPORTIMAGE: {

            _share(RShareSDKQQ, RShareResultFailure, @"QQ空间不支持的 Image 类型分享!");
            break;
        }
        default:
            break;
    }
}


#pragma mark - TencentSessionDelegate -
- (void)tencentDidLogin {
    NSLog(@"QQ已登录");
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    NSLog(@"QQ未登录");
}

- (void)tencentDidNotNetWork {
    NSLog(@"无网络连接");
}


#pragma mark - QQApiInterfaceDelegate -

- (void)onReq:(QQBaseReq *)req {

}
- (void)onResp:(QQBaseResp *)resp {
    
    
    if (!_share) { return; }
    
    if ([resp.class isSubclassOfClass:[SendMessageToQQResp class]]) {
        
        if ([resp.result isEqualToString:@"0"]) {
            
             _share(RShareSDKQQ, RShareResultSuccess ,nil);
            
        } else if ([resp.result isEqualToString:@"-4"]) {
            
            _share(RShareSDKQQ, RShareResultCancel ,nil);
            
        } else {
            _share(RShareSDKQQ, RShareResultFailure, resp.errorDescription);
        }
       
    }
}

- (void)isOnlineResponse:(NSDictionary *)response {}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    [QQApiInterface handleOpenURL:url delegate:self];

    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [QQApiInterface handleOpenURL:url delegate:self];

    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}



@end
