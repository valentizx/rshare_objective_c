//
//  RShare.h
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPlatform.h"
#import "RRegister.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShareResult) {
    RShareResultSuccess,
    RShareResultCancel,
    RShareResultFailure
};

/**
 分享 Mode 仅对部分分享生效
 */
typedef NS_ENUM(NSInteger, Mode) {
    /**
     @Displays 优先选择原生应用分享, 原生应用未安装的情况可能跳转内置 WebView 或者 Safari 进行分享.
     */
    ShareModeAutomatic,
    /**
     @Displays 原生应用分享.
     */
    ShareModeNative,
    /**
     @Displays 应用内置 UIWebView 分享.
     */
    ShareModeWeb,
    /**
     @Displays the dialog in the iOS integrated share sheet, 仅对 Facebook 分享有效.
     */
    ShareModeSheet,
    /**
     @Displays 跳转至 Safari 分享, 仅对 Facebook 分享有效.
     */
    ShareModeBrowser,
    /**
     @Displays 跳转至 Safari 进行 Feed 形式的分享, 仅对 Facebook 分享有效.
     */
    ShareModeFeedBrowser,
    /**
     @Displays 应用内置 UIWebView 的 Feed 形式分享, 仅对 Facebook 分享有效.
     */
    ShareModeFeed,
    /**
     @Displays iOS 的系统分享, 通过 Document Interaction 搭建分享凭借, 仅对 Instagram 有效.
     */
    ShareModeSystem
};

typedef void (^RShareCompletion)(RShareSDKPlatform platform, ShareResult result, NSString* _Nullable errorInfo);

typedef void (^RConfiguration)(RShareSDKPlatform platform, RRegister* obj);

@interface RShare : NSObject

- (void)connect:(RConfiguration)c;

@end
