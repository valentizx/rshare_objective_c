//
//  RShareManager.m
//  sharekit
//
//  Created by valenti on 2018/6/27.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShareManager.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "RFacebookManager.h"
#import "RQqManager.h"
#import "RWechatManager.h"
#import "RTwitterManager.h"
#import "RLineManager.h"
#import "RGooglePlusManager.h"
#import "RPinterestManager.h"
#import "RTumblrManager.h"
#import "RWhatsAppManager.h"
#import "RSinaWeiboManager.h"
#import "RInstagramManager.h"
#import "NSString+Extension.h"


@interface RShareManager()

@property (nonatomic, strong) Class cls;

@end

@implementation RShareManager

static RShareManager* _instance = nil;

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

#pragma mark - 分享逻辑 -
- (void)shareVideoWithContent:(RVideoContent *)content
                      channel:(RShareChannel)channel
                         from:(UIViewController *)from
                   completion:(RShareCompletion)completion {
    
    _cls = [self getCls:channel];
    switch (channel) {
        case RShareChannelQQDataLine: {
            NSData* videoData = [NSData dataWithContentsOfFile:[content.videoFileURL path]];
            NSString* fileName = [NSString stringWithFormat:@"%@,%@", [NSString randomFileName],[content.videoFileURL path].extension ];
        
            [[RQqManager shared] shareFileToQQWithFileData:videoData fileName:fileName title:content.title description:content.quote thumbImage:content.thumbImage completion:completion];
        }
            break;
        case RShareChannelQZone:

            [[RQqManager shared] shareVideoToQZoneWithAssetURL:content.videoAssetURL description:content.quote completion:completion];
            break;
        case RShareChannelWechatSession: {
            NSData* videoData = [NSData dataWithContentsOfFile:[content.videoFileURL path]];
            [[RWechatManager shared] shareFileWithData:videoData extension:[content.videoFileURL path].extension title:content.title thumbImage:content.thumbImage scene:Session completion:completion];
            
        }
            break;

        case RShareChannelWechatFavorite: {
            NSData* videoData = [NSData dataWithContentsOfFile:[content.videoFileURL path]];
            [[RWechatManager shared] shareFileWithData:videoData extension:[content.videoFileURL path].extension title:content.title thumbImage:content.thumbImage scene:Favorite completion:completion];
            
        }
        break;

        case RShareChannelSinaWeibo:
            [[RSinaWeiboManager shared] shareVideoWithLocalURL:content.videoFileURL text:content.quote toStory:NO completion:completion];
            break;
            
        case RShareChannelSinaWeiboStory:
            [[RSinaWeiboManager shared] shareVideoWithLocalURL:content.videoFileURL text:content.quote toStory:YES completion:completion];
            break;
            
        case RShareChannelInstagram:
            [[RInstagramManager shared] shareVideoWithLocalURL:content.videoFileURL description:content.quote];
            break;
        case RShareChannelFacebookClient:
            [[RFacebookManager shared] shareVideoWithLocalURL:content.videoAssetURL from:from];
            break;

        default:
            NSLog(@"⚠️ 该方式不支持视频分享!");
            break;
    }
    
}

- (void)shareTextWithContent:(RTextContent *)content
                     channel:(RShareChannel)channel
                        from:(UIViewController *)from
                  completion:(RShareCompletion)completion {
    
    _cls = [self getCls:channel];
    switch (channel) {
            
        case RShareChannelQQSession:
            [[RQqManager shared]shareTextToQQ:content.body scene:RQQShareAutomatic completion:completion];
            
            break;
        case RShareChannelQQFavorite:
            [[RQqManager shared]shareTextToQQ:content.body scene:RQQShareFavorites completion:completion];
            break;
        case RShareChannelQQDataLine:
            [[RQqManager shared]shareTextToQQ:content.body scene:RQQShareDataline completion:completion];
            break;
        case RShareChannelQZone:
            [[RQqManager shared] shareTextToQZone:content.body completion:completion];
            break;
        case RShareChannelWechatSession:
            [[RWechatManager shared] shareText:content.body scene:Session completion:completion];
            break;
            
        case RShareChannelWechatFavorite:
            [[RWechatManager shared] shareText:content.body scene:Favorite completion:completion];
            break;
            
        case RShareChannelWechatTimeline:
            [[RWechatManager shared] shareText:content.body scene:Timeline completion:completion];
            break;
            
        case RShareChannelSinaWeibo:
            [[RSinaWeiboManager shared] shareText:content.body completion:completion];
            break;
            
        case RShareChannelTumblr:
            [[RTumblrManager shared] shareText:content.body title:content.title webpageURL:content.webpageURL from:from completion:completion];
            break;
        case RShareChannelLine:
            [[RLineManager shared]shareText:content.body];
            break;
        case RShareChannelWhatsApp:
            [[RWhatsAppManager shared] shareText:content.body];
            break;
        case RShareChannelTwitter:
            [[RTwitterManager shared] shareWithWebpageURL:nil text:content.body image:nil from:from completion:completion];
            break;
        default:
            NSLog(@"⚠️ 该方式不支持文本分享!");
            break;
    }
    
}
- (void)shareImageWithContent:(RImageContent *)content
                      channel:(RShareChannel)channel
                         from:(UIViewController *)from
                   completion:(RShareCompletion)completion {
    
    _cls = [self getCls:channel];
    switch (channel) {
            
        case RShareChannelQQSession:
            [[RQqManager shared] shareImageToQQ:content.image title:content.title description:content.quote scene:RQQShareAutomatic completion:completion];
            
            break;
        case RShareChannelQQFavorite:
            [[RQqManager shared] shareImageToQQ:content.image title:content.title description:content.quote scene:RQQShareFavorites completion:completion];
            
            break;
        case RShareChannelQQDataLine:
            [[RQqManager shared] shareImageToQQ:content.image title:content.title description:content.quote scene:RQQShareDataline completion:completion];
            
            break;
        case RShareChannelQZone:
            [[RQqManager shared] shareImagesToQZone:@[content.image] description:content.quote completion:completion];
            break;
        case RShareChannelWechatSession:
            [[RWechatManager shared] shareImage:content.image scene:Session completion:completion];
            break;
            
        case RShareChannelWechatFavorite:
            [[RWechatManager shared] shareImage:content.image scene:Favorite completion:completion];
            break;
            
        case RShareChannelWechatTimeline:
           [[RWechatManager shared] shareImage:content.image scene:Timeline completion:completion];
            break;
            
        case RShareChannelSinaWeibo:
            [[RSinaWeiboManager shared] shareImage:@[content.image] text:content.quote toStory:NO completion:completion];
            break;
        case RShareChannelSinaWeiboStory:
            [[RSinaWeiboManager shared] shareImage:@[content.image] text:content.quote toStory:YES completion:completion];
            break;
            
        case RShareChannelTumblr: {
            if (content.imageURL != nil) {
                [[RTumblrManager shared] shareImageWithURL:content.imageURL description:content.quote webpageURL:content.webpageURL from:from completion:completion];
            }
        }
            break;
        case RShareChannelLine:
            [[RLineManager shared]shareImage:content.image];
            break;
        case RShareChannelWhatsApp:
            [[RWhatsAppManager shared] shareImage:content.image from:from];
            break;
        case RShareChannelTwitter:
            [[RTwitterManager shared] shareWithWebpageURL:nil text:content.quote image:content.image from:from completion:completion];
            break;
        
        case RShareChannelInstagram:
            [[RInstagramManager shared] share:content.image];
            break;
        case RShareChannelPinterest:
            if (content.imageURL != nil) {
                [[RPinterestManager shared] shareImageWithURL:content.imageURL webpageURL:content.webpageURL onBoard:@"" description:content.quote from:from completion:completion];
            }
            break;
        case RShareChannelFacebookClient:
            [[RFacebookManager shared] sharePhotos:@[content.image] from:from completion:completion];
            
        default:
            NSLog(@"⚠️ 该方式不支持图片分享!");
            break;
    }
    
}

-(void)shareWebpageWithContent:(RWebpageContent *)content
                       channel:(RShareChannel)channel
                          from:(UIViewController *)from
                    completion:(RShareCompletion)completion {
    
    _cls = [self getCls:channel];
    switch (channel) {
            
        case RShareChannelQQSession:
            [[RQqManager shared] shareWebpageToQQWithURL:content.webpageURL title:content.title description:content.description thumbImage:content.thumbImage scene:RQQShareAutomatic completion:completion];
            
            break;
        case RShareChannelQQFavorite:
            [[RQqManager shared] shareWebpageToQQWithURL:content.webpageURL title:content.title description:content.description thumbImage:content.thumbImage scene:RQQShareFavorites completion:completion];
            
            break;
        case RShareChannelQQDataLine:
            [[RQqManager shared] shareWebpageToQQWithURL:content.webpageURL title:content.title description:content.description thumbImage:content.thumbImage scene:RQQShareDataline completion:completion];
            
            break;
        case RShareChannelQZone:
            [[RQqManager shared] shareTextToQZone:content.webpageURL completion:completion];
            break;
        case RShareChannelWechatSession:
            [[RWechatManager shared] shareWebpageWithURL:content.webpageURL title:content.title description:content.quote thumbImage:content.thumbImage scene:Session completion:completion];
            break;
            
        case RShareChannelWechatFavorite:
            [[RWechatManager shared] shareWebpageWithURL:content.webpageURL title:content.title description:content.quote thumbImage:content.thumbImage scene:Favorite completion:completion];
            break;
            
        case RShareChannelWechatTimeline:
            [[RWechatManager shared] shareWebpageWithURL:content.webpageURL title:content.title description:content.quote thumbImage:content.thumbImage scene:Timeline completion:completion];
            break;
            
        case RShareChannelSinaWeibo:
            [[RSinaWeiboManager shared] shareWebpageWithURL:content.webpageURL objectID:@"" title:content.title description:content.quote thumbImage:content.thumbImage completion:completion];
            break;
        
            
        case RShareChannelTumblr:
            [[RTumblrManager shared] shareText:content.quote title:content.title webpageURL:content.webpageURL from:from completion:completion];
            break;
        case RShareChannelLine:
            [[RLineManager shared]shareText:content.webpageURL];
            break;
        case RShareChannelWhatsApp:
            [[RWhatsAppManager shared] shareText:content.webpageURL];
            break;
        case RShareChannelTwitter:
            [[RTwitterManager shared] shareWithWebpageURL:content.webpageURL text:content.quote image:content.thumbImage from:from completion:completion];
            break;
        case RShareChannelFacebookClient:
            [[RFacebookManager shared] shareWebpageWithURL:content.webpageURL quote:content.quote hashTag:content.hashTag from:from mode:ShareModeAutomatic completion:completion];
            break;
        case RShareChannelFacebookBroswer:
             [[RFacebookManager shared] shareWebpageWithURL:content.webpageURL quote:content.quote hashTag:content.hashTag from:from mode:ShareModeFeed completion:completion];
            break;
        case RShareChannelGooglePlus:
            [[RGooglePlusManager shared]shareURL:[NSURL URLWithString:content.webpageURL] from:from];
            
            
        default:
            NSLog(@"⚠️ 该方式不支持网页分享!");
            break;
    }
    
}

#pragma mark - 初始化平台 -
- (void)registerPlatforms:(RPlatform *)p
          onConfiguration:(RConfiguration)c {
    
    for (int i = 0; i < p.targets.count; i ++) {
        @autoreleasepool {
            Class cls = p.targets[i];
            id obj = objc_msgSend(objc_msgSend(cls, @selector(alloc)), @selector(init));
            SEL sel = @selector(connect:);
            ((void(*)(id,SEL, RConfiguration))objc_msgSend)(obj, sel, c);
        }
    }
}


#pragma mark - 应用回转 -
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    SEL sel = @selector(application:openURL:options:);
    id obj = objc_msgSend(objc_msgSend(_cls, @selector(alloc)), @selector(init));
    return ((BOOL(*)(id,SEL,id,id,id))objc_msgSend)(obj, sel, application,url,options);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    id obj = objc_msgSend(objc_msgSend(_cls, @selector(alloc)), @selector(init));
    SEL sel = @selector(application:openURL:sourceApplication:annotation:);
    
    return ((BOOL(*)(id,SEL,id,id,id,id))objc_msgSend)(obj, sel, application,url,sourceApplication,annotation);
}


#pragma mark - Facebook 配置 -

// 暂时只有 Facebook
- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[RFacebookManager shared]application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[RFacebookManager shared] applicationDidBecomeActive:application];
}

#pragma mark - 其他

-(Class)getCls:(RShareChannel)channel {
    switch (channel) {
        case RShareChannelQQSession:
        case RShareChannelQQFavorite:
        case RShareChannelQQDataLine:
        case RShareChannelQZone:
            return RQqManager.class;
            
        case RShareChannelWechatSession:
        case RShareChannelWechatFavorite:
        case RShareChannelWechatTimeline:
            return RWechatManager.class;
            
        case RShareChannelFacebookClient:
        case RShareChannelFacebookBroswer:
            return RFacebookManager.class;
            
        case RShareChannelTwitter:
            return RTwitterManager.class;
            
        case RShareChannelSinaWeibo:
        case RShareChannelSinaWeiboStory:
           return RSinaWeiboManager.class;
            
        case RShareChannelLine:
            return RLineManager.class;
            
        case RShareChannelInstagram:
            return RInstagramManager.class;
        case RShareChannelTumblr:
            return RTumblrManager.class;
        case RShareChannelPinterest:
            return RPinterestManager.class;
        case RShareChannelGooglePlus:
            return RGooglePlusManager.class;
        case RShareChannelWhatsApp:
            return RWhatsAppManager.class;
    }
}
@end
