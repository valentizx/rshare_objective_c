//
//  RSinaWeiboManager.m
//  sharekit
//
//  Created by valenti on 2018/6/6.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RSinaWeiboManager.h"
#import "WeiboSDK.h"
#import "RPlatform.h"

@interface RSinaWeiboManager()<WeiboSDKDelegate, WBMediaTransferProtocol>

@property (nonatomic, copy) RShareCompletion share;
@property (nonatomic, strong) WBMessageObject* message;
@property (nonatomic, strong) WBSendMessageToWeiboRequest* request;

@end

@implementation RSinaWeiboManager

static RSinaWeiboManager* _instance = nil;

- (WBMessageObject *)message {
    if (_message == nil) {
        _message = [WBMessageObject message];
    }
    return _message;
}

- (WBSendMessageToWeiboRequest*)request {
    if (_request == nil) {
        _request = [WBSendMessageToWeiboRequest requestWithMessage:self.message];
    }
    return _request;
}

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

- (void)sdkInitializeByAppKey:(NSString *)key appSecret:(NSString *)secret {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:key];
}

#pragma mark - 分享逻辑 -

- (void)shareText:(NSString *)text completion:(RShareCompletion)share {
    
    
    if (![RPlatform isInstalled:RShareSDKSina]) {
        NSLog(@"新浪微博未安装");
        return;
    }
    
    _share = share;
    [self.message setText:text];
    [WeiboSDK sendRequest:self.request];
}

- (void)shareImage:(NSArray<UIImage *> *)images
              text:(NSString*)text
           toStory:(BOOL)isToStory
         completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKSina]) {
        NSLog(@"新浪微博未安装");
        return;
    }
    
    _share = share;
    WBImageObject* obj = [WBImageObject object];
    
    obj.isShareToStory = isToStory;
    obj.delegate = self;
    [obj addImages:images];
    self.message.imageObject = obj;
    self.message.text = text;
    // 由于 addImages 函数是异步操作, 所以必须在 wbsdk_TransferDidReceiveObject 回调中发送分享请求!⚠️
}

- (void)shareVideoWithLocalURL:(NSURL *)localVideoURL
                           text:(NSString *)text
                        toStory:(BOOL)isToStory
                      completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKSina]) {
        NSLog(@"新浪微博未安装");
        return;
    }
    _share = share;
    
    WBNewVideoObject* obj = [WBNewVideoObject object];
    obj.isShareToStory = isToStory;
    obj.delegate = self;
    [obj addVideo:localVideoURL];
    self.message.videoObject = obj;
    self.message.text = text;
    // 由于 addVideo 函数是异步操作, 所以必须在 wbsdk_TransferDidReceiveObject 回调中发送分享请求!⚠️
}

- (void)shareWebpageWithURL:(NSString *)webpageURL
                   objectID:(NSString*)objectID
                      title:(NSString *)title
                description:(NSString *)description
                 thumbImage:(UIImage *)image
                   completion:(RShareCompletion)share {
    
    if (![RPlatform isInstalled:RShareSDKSina]) {
        NSLog(@"新浪微博未安装");
        return;
    }
    
    WBWebpageObject* obj = [WBWebpageObject object];
    obj.title = title;
    obj.objectID = objectID;
    obj.thumbnailData = UIImagePNGRepresentation(image);
    obj.webpageUrl = webpageURL;
    
    self.message.mediaObject = obj;
    self.message.text = description;
    [WeiboSDK sendRequest:self.request];
}

#pragma mark - 应用回转 -
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WeiboSDK handleOpenURL:url delegate:self];
    
}


#pragma mark - WeiboSDKDelegate -
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
    _request = nil;
    _message = nil;
    
    if (_share) {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            _share(RShareSDKSina, RShareResultSuccess, nil);
        } else if(response.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
            _share(RShareSDKSina, RShareResultCancel, nil);
        } else {
            _share(RShareSDKSina, RShareResultFailure, @"发送失败");
        }
    }
}

#pragma mark - WBMediaTransferProtocol -

/**
 数据准备失败回调
 */
- (void)wbsdk_TransferDidFailWithErrorCode:(WBSDKMediaTransferErrorCode)errorCode andError:(NSError *)error {
    if (_share) {
        /***
         * 数据准备失败说明:
         * 1, 图片、视频体积过大;
         * 2, 图片数量不在 1 - 9 范围内;
         * 3, 倘若分享到「微博故事」, 照片只能分享一张, 而传了多张图片;
         * 4, WBImageObject 多参数并存: 单张的 Data 格式的图片和图片数组共存.
         */
        
        NSString* errorInfo = nil;
        if (errorCode == WBSDKMediaTransferAlbumPermissionError ) {
            errorInfo = @"相册权限不够";
        } else if (errorCode == WBSDKMediaTransferAlbumWriteError){
            errorInfo = @"相册写入错误";
        } else if (errorCode == WBSDKMediaTransferAlbumAssetTypeError) {
            errorInfo = @"资源类型错误";
        } else {
            errorInfo = @"参数准备错误";
        }
        _share(RShareSDKSina, RShareResultFailure, errorInfo);
    }
}

/**
 数据准备成功回调
 */
- (void)wbsdk_TransferDidReceiveObject:(id)object {
    
    [WeiboSDK sendRequest:self.request];
}

@end
