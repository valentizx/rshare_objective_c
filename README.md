# RSHARE Objective-C Version

RSHARE 这个 Demo 中支持: 微信、QQ、新浪微博、Facebook、GooglePlus(Google +)、Twitter、WhatsApp、Line、Tumblr、Instagram、Pinterest 11 个 Social 平台.

❤️🧡💛💚💙💜🖤
[详细设计、注意事项](https://rexzx.github.io/2018/08/28/rshare-ios-vesion/)
❤️🧡💛💚💙💜🖤

### QQ
#### 准备
分享需要注册平台, [腾讯开发者主页](http://open.qq.com/), [SDK 下载](http://wiki.open.qq.com/wiki/mobile/SDK%E4%B8%8B%E8%BD%BD), QQ SDK 目前**不支持 pod 安装**, iOS API 调用说明[文档](http://wiki.open.qq.com/index.php?title=iOS_API%E8%B0%83%E7%94%A8%E8%AF%B4%E6%98%8E&oldid=46716).
#### 集成
a. ``TencentOpenAPI.framework``导入项目中;
b. 添加系统依赖``Security.framework``、``SystemConfiguration.framework``、``CoreGraphic.framework``、``libsqilte3.0.tbd``、``CoreTelephony.framework``、``libz.tbd``.
c. 设置 **The Other Flags** 为 **-ObjC**.
d. 在``info.plist``文件的``CFBundleURLTypes``中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>tencentYOURAPPID</string>
</array>
```
e. 添加以下至白名单:

```objc
<string>mqq</string>
<string>mqqapi</string>
<string>mqqwpa</string>
<string>mqqbrowser</string>
<string>mttbrowser</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV4</string>
<string>wtloginmqq2</string>
<string>mqzone</string>
<string>mqzoneopensdk</string>
<string>mqzoneopensdkapi</string>
<string>mqzoneopensdkapi19</string>
<string>mqzoneopensdkapiV2</string>
<string>mqqapiwallet</string>
<string>mqqopensdkfriend</string>
<string>mqqopensdkdataline</string>
<string>mqqgamebindinggroup</string>
<string>mqqopensdkgrouptribeshare</string>
<string>tencentapi.qq.reqContent</string>
<string>tencentapi.qzone.reqContent</string>
```


#### 接口调用

**a. 初始化 SDK**

```objc
[[RQqManager shared] sdkInitializeByAppID:yourAppId appKey:yourAppKey];
```

**b. 分享**

**文字分享:**

```objc
[[RQqManager shared] shareTextToQQ:text scene:scene completion:completion];
```

**图片分享:**


```objc
[[RQqManager shared] shareImageToQQ:targetImage title:title description:description scene:scene completion:completion];
```


**网页分享:**


```objc
[[RQqManager shared] shareWebpageToQQWithURL:webpageURL title:title description:description thumbImage:image scene:scene completion:completion];
```


**视频链分享:**
实质就是网页的分享, 在此不作代码示例.

**音频链分享:**


```objc
[[RQqManager shared] shareAudioToQQWithStreamURL:audioStreamURL title:title description:description thumbImage:image webpageURL:webpageURL scene:scene completion: completion];
```




**文件分享:**


```objc 
[[RQqManager shared] shareFileToQQWithFileData:fileData fileName:fileName title:title description:description thumbImage:image completion: completion];
```




**文字分享到 QQ 空间:**


```objc
[[RQqManager shared] shareTextToQZone:description completion: completion];
```



**分享图片到 QQ 空间:**


```objc
[[RQqManager shared] shareImagesToQZone: targetImageArray  description:description completion: completion];
```


**分享本地视频到 QQ 空间:**


```objc
[[RQqManager shared] shareVideoToQZoneWithAssetURL:videoAssetURL description:description completion: completion];
```

**c. 返回本应用**


```objc
[[RQqManager shared] application:app openURL:url options: options];
```


### 微信
#### 准备
分享需要注册平台, [微信开放平台](https://open.weixin.qq.com/), [SDK 下载](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=open1419319164&token=015161c07a6a155cf6424904a9febe4301efaa49&lang=zh_CN), 微信 SDK **支持 pod 安装**, [分享 & 收藏 API 调用说明](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=open1419317332&token=&lang=zh_CN).



#### 集成
a. 手动: ``libWeChatSDK.a``、``WXApi.h``、``WXApiObject.h``, 导入项目中;
pod 集成: ``pod 'WechatOpenSDK'``, 若出现:
> Use the $(inherited) flag, or
> Remove the build settings from the target.
> 🔧解决方法(引自[微信集成说明](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN), 未亲自测试): 把工程 target 中的 build Setting 里面 **PODS_ROOT** 的值替换成 **\$(inherited)**, **Other Linker Flags** 中 **-all_load** 替换成 **\$(inherited).**

b. 添加系统依赖 ``SystemConfiguration.framework``, ``libz.dylib``, ``libsqlite3.0.dylib``, ``libc++.dylib``, ``Security.framework``, ``CoreTelephony.framework``, ``CFNetwork.framework``.
c. 手动集成的情况下, 需设置 **The Other Flags** 为 **-ObjC**.
d. 在`` info.plist`` 文件的 ``CFBundleURLTypes`` 中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>wxYOURAPPID</string>
</array>
```
e. 添加以下至白名单:

```objc
<string>weixin</string>
<string>wechat</string>
```


#### 接口调用

**a. 初始化 SDK**


```objc
[[RWechatManager shared] sdkInitializeByAppID:appID appSecret:secret];
```

**b. 分享**

**文字分享:**



```objc
[[RWechatManager shared] shareText:text scene: scene completion: completion];
```



**图片分享:**


```objc
[[RWechatManager shared] shareImage:targetImage scene: scene completion: completion];
```



**网页分享:**


```objc
[[RWechatManager shared] shareWebpageWithURL:webpageURL title:title description:description thumbImage:thumbImage scene: scene completion: completion];
```



**视频链分享:**
实质就是网页的分享, 在此不作代码示例.

**音频链分享:**


```objc
[[RWechatManager shared] shareMusicWithStreamURL: audioStreamURL webpageURL:audioWebpageURL title: title description: description thumbImage:image scene:scene completion: completion];
```




**小程序分享:**


```objc
[[RWechatManager shared] shareMiniProgramWithUserName:userName path:path type:type webpageURL:webpageURL title:title description:description thumbImage:image scene: scene completion: completion];
```


**文件分享:**


```objc
[[RWechatManager shared] shareFileWithData:fileData extension:fileExtensionName title:title thumbImage:image scene:scene completion: completion];
```



**c. 返回本应用**


```objc
[[RWechatManager shared] application:app openURL:url options:options];
```

### 新浪
#### 准备

分享需要注册平台, [新浪开放平台](http://open.weibo.com/), [SDK 下载](http://open.weibo.com/wiki/SDK#iOS_SDK), 新浪 SDK **支持 pod 安装**, [iOS 接口调用文档](https://github.com/sinaweibosdk/weibo_ios_sdk).



#### 集成

a. 手动导入 ``WeiboSDK.h``、 ``WBHttpRequest.h``、``libWeiboSDK.a`` 和 ``WeiboSDK.bundle`` 到项目中.
pod 集成: ``pod "Weibo_SDK", :git => "https://github.com/sinaweibosdk/weibo_ios_sdk.git"`` (未实际测试过).

b. 添加系统依赖``QuartzCore.framework``、``SystemConfiguration.framework``、``ImageIO.framework``、``CoreGraphic.framework``、``Security.framework``、``libsqilte3.0.tbd``、``CoreTelephony.framework``、``CoreText.framework``、``libz.tbd``.
c. 设置 **The Other Flags** 为 **-ObjC**.
d. 在 ``info.plist`` 文件的 ``CFBundleURLTypes`` 中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>wbYOURAPPKEY</string>
</array>
```

e.对传输安全的支持, 在当下的 iOS 系统中，默认需要为每次网络传输建立 **SSL**, 所以需在 plist 中设置 **NSAppTransportSecurity 的 NSAllowsArbitraryLoads** 为 **YES**.

f. 解除原有 **ATS**设置在 iOS 10+ 的网络限制:

```objc
<key>sina.com.cn</key>
  	<dict>
  		<key>NSIncludesSubdomains</key>
  		<true/>
  		<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
  		<true/>
  		<key>NSExceptionMinimumTLSVersion</key>
  		<string>TLSv1.0</string>
  		<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
  		<false/>
  	</dict>
```

g. 添加以下至白名单:

```objc
<string>sinaweibohd</string>
<string>sinaweibo</string>
<string>weibosdk</string>
<string>weibosdk2.5</string>
```

#### 接口调用

**a. 初始化 SDK**


```objc
[[RSinaWeiboManager shared] sdkInitializeByAppKey:YourAppKey appSecret:YourAppSecret];
```

**b. 分享**


**文字分享:**


```objc
[[RSinaWeiboManager shared] shareText: text completion: completion];
```



**图片分享:**


```objc
[[RSinaWeiboManager shared] shareImage:images text: text toStory: yesOrNo completion: completion];
```


**本地视频分享:**


```objc
[[RSinaWeiboManager shared] shareVideoWithLocalURL:videoFileURL text:text toStory:YesOrNo completion: completion];
```



**网页分享:**


```objc
[[RSinaWeiboManager shared] shareWebpageWithURL: webpageURL objectID: @"id" title: title description: description thumbImage:thumbImage completion: completion];
```



**c. 返回本应用**


```objc
[[RSinaWeiboManager shared] application:app openURL:url options:options];
```


### Facebook
#### 准备
分享需要注册平台, [Facebook 开发者主页](https://developers.facebook.com/), Facebook SDK **支持 pod 集成**, [分享接口调用说明](https://developers.facebook.com/docs/sharing/ios).
#### 集成
a. pod 集成: ``pod 'FBSDKLoginKit'``
b. 在``info.plist``文件的``CFBundleURLTypes``中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>fbYOURAPPID</string>
</array>
<key>FacebookAppID</key>
<string>YOURAPPID</string>
<key>FacebookDisplayName</key>
<string>SOMENAME</string>
```
c. 添加以下至白名单:

```objc
<string>fbapi</string>
<string>fb-messenger-share-api</string>
<string>fbauth2</string>
<string>fbshareextension</string>
```


#### 接口调用

**a. 初始化 SDK**


```objc
[[RFacebookManager shared] sdkInitializeByID:appID secret:secret];
```


**b. 分享**

**网页分享:**

```objc
[[RFacebookManager shared] shareWebpageWithURL: webpageURL
                           quote: quote
                         hashTag: hashTag
                            from: context
                            mode: mode
                      completion: completion];
```



**图片分享:**


```objc
[[RFacebookManager shared] sharePhotos: targetImageArray
                    from:context
              completion: completion];
```


**本地视频分享:**


```objc
[[RFacebookManager shared] shareVideoWithLocalURL: videoURL from: context];
```


**C. 返回本应用**


```objc
[[RFacebookManager shared]application:app openURL:url options:options];
```

**d. 其他设置**

在完成 Facebook 登录、分享等操作的时候还需要连接本应用的 ``AppDelegate`` , 故在 ``didFinishLaunchingWithOptions`` 函数中添加:


```objc
[[RFacebookManager shared] application:application didFinishLaunchingWithOptions:launchOptions];
```

当需要记录有多少用户激活的时候需要在 ``applicationDidBecomeActive`` 方法中添加:


```objc
[[RFacebookManager shared]applicationDidBecomeActive:application];
```

### Twitter
#### 准备
分享需要注册平台, [Twitter 开发者主页](https://developer.twitter.com/content/developer-twitter/en.html), [注册应用主页](https://apps.twitter.com/), Twitter SDK **支持 pod 集成**, [分享接口调用说明](https://github.com/twitter/twitter-kit-ios/wiki/Compose-Tweets).

**⚠️: Twitter SDK 将于 2018/10/31 后不再进行维护, 但是不影响后续使用, 需自行维护, [Twitter 产品经理 Neil Shah 对 Twitter SDK 放弃维护迭代的声明博客](https://blog.twitter.com/developer/en_us/topics/tools/2018/discontinuing-support-for-twitter-kit-sdk.html).**
#### 集成
a. pod 集成: ``pod 'TwitterKit'``
b. 在 ``info.plist`` 文件的``CFBundleURLTypes``中添加:

```objc
<key>CFBundleURLSchemes</key>
<array>
    <string>twitterkit-YOURCONSUMERKEY</string>
</array>
```
c. 添加以下至白名单:

```objc
<string>twitter</string>
<string>twitterauth</string>
```

#### 接口调用

**a. 初始化 SDK**

```objc
[[RTwitterManager shared] sdkInitializeByConsumerKey:yourConsumerKey consumerSecret:yourConsumerSecret];
```

**b. 授权 Twitter 客户端**

登录(授权回调):


```objc
typedef void (^auth)(RTWAuthState state, NSString* _Nullable errorInfo);
```

**判断是否登录过:**


```objc
BOOL flag = [[RTwitterAuthHepler shared] hasLogged];
```


**登录授权:**


```objc
[[RTwitterAuthHelper shared]authorizeTwitter:^(RTWAuthState state, NSString * _Nullable errorInfo) {
    // some code ...
}];
```


**返回本应用:**


```objc
[[RTwitterManager shared] application:app openURL:url options:options];
```


**c. 分享**

```objc
[[RTwitterManager shared]shareWithWebpageURL: webpageURL text: description image: image from: context completion: completion];
```

### Instagram
#### 准备

分享无需注册平台无需 SDK, [Instagram 开发者主页](https://www.instagram.com/developer/), [Custom URL Scheme 方式分享](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/).

#### 配置

在```info.plist```文件中:
添加以下至白名单:

```objc
<string>instagram</string>
```

#### 接口调用及内部实现

**分享**


**分享图片:**

```objc
[[RInstagramManager shared] share: targetImage];
```

**分享本地视频:**


```objc
[[RInstagramManager shared]shareVideoWithLocalURL: videoURL description: description]
```



### Tumblr
#### 准备
分享需要注册平台, [Tumblr 开发者主页](https://www.tumblr.com/developers), [注册应用主页](https://dev.flurry.com/admin/applications), Tumblr SDK **支持 pod 集成**, [分享接口调用说明](https://developer.yahoo.com/flurry/docs/tumblrsharing/iOS/).

#### 集成
a. pod 集成: ``pod 'Flurry-iOS-SDK/TumblrAPI'``
⚠️: 一定是这个, 最新版本的 SDK 我没有找到分享的接口.

b. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.



#### 接口调用及内部实现

**a. 初始化 SDK**


```objc
[[RTumblrManager shared] sdkInitializeByConsumerKey:yourConsumerKey consumerSecret: yourConsumerSecret];
```


**b. 分享**


**文字分享:**


```objc
[[RTumblrManager shared] shareText: text title: title webpageURL: webpageURL from: context completion: completion];
```



**图片链接分享:**


```objc
[[RTumblrManager shared] shareImageWithURL: targetImageURL description: description webpageURL: webpageURL from: context completion: completion];
```



### Pinterest
#### 准备
分享需要注册平台, [Pinterest 开发者主页](https://developers.pinterest.com/), [注册应用主页](https://developers.pinterest.com/apps/), Pinterest SDK **支持 pod 集成**, [接口调用说明](https://developers.pinterest.com/docs/sdks/ios/).

#### 集成
a. pod 集成: ``pod “PinterestSDK”, :git => “git@github.com:pinterest/ios-pdk.git”``

d. 在 ``info.plist`` 文件的 ``CFBundleURLTypes`` 中添加:

```objc
<key>CFBundleURLTypes</key>
  <array>
    <dict>
      <key>CFBundleURLName</key>
      <string></string>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>pdkYOURAPPID</string>
      </array>
    </dict>
  </array>
```
e. 添加以下至白名单:

```objc
<string>pinterestsdk.v1</string>
```

b. Swift 语言集成需要 **Objective-C - Swift 桥接文件**.



#### 接口调用及内部实现

**a. 初始化 SDK**


```objc
[[RPinterestManager shared] sdkInitializeByAppID: yourAppID appSecret:yourAppSecret];
```

**b. 分享**

**图片链接分享:**


```objc
[[RPinterestManager shared] shareImageWithURL: targetImageURL webpageURL: webpageURL onBoard:boardName description: description  from: context completion:completion];
```

**c. 返回本应用**


```objc
[[RPinterestManager shared] application:app openURL:url options:nil];
```

### Line
#### 准备
分享无需注册平台.


#### 配置

在``info.plist``文件中:
添加以下至白名单:

```objc
<string>line</string>
```

#### 接口调用

**分享**


**文字分享:**
 

```objc
[[RLineManager shared] shareText: text];
```

**图片分享:**


```objc
[[RLineManager shared] shareImage: targetImage];
```


### WhatsApp
#### 准备
分享无需注册平台.


#### 配置

在``info.plist``文件中:
添加以下至白名单:

```objc
<string>whatsapp</string
```
#### 接口调用

**分享**

**文字分享:**


```objc
[[RWhatsAppManager shared]shareText: text]
```


**图片分享:**

```objc
[[RWhatsAppManager shared]shareImage: targetImage from: context];
```


### GooglePlus
#### 准备
分享无需注册平台, [Google Plus 开发者主页](https://developers.google.com/+/)已经把 iOS 相关移除了.

#### 接口调用

**分享**

**网页分享:**

```objc
[[RGooglePlusManager shared]shareURL:[NSURL URLWithString: targetURL] from: context];
```



## 统一分享接口



### 类
![iOS 分享统一接口类图](https://lh3.googleusercontent.com/-qS7DNoxlpi0/W4YRwCQ7qhI/AAAAAAAAATw/2KMok4xcqTg-qLFtY9V9h9xV8ys8jf9sgCHMYCw/I/iOS%2B)


- **RShareManger:** 主分享 Manager, 子平台 Manager 的初始化、分享、应用跳转和一些其他操作都在此进行;
- **RPlatform:** 主要进行应用是否安装、添加目标应用的操作;
- **RRegister:** 主要进行 ``RShareManager`` 和子平台分享 Manager 的 SDK 初始化衔接;
- **RImageContent、RVideoContent、RTextContent、RWebpageContent** 为四种对应分享内容模型.

### 接口调用

**添加平台及初始化需要注册的平台:**


```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RPlatform* p = [RPlatform make:^(PlatformBuilder *builder) {
        [builder add:RShareSDKPinterest];
        [builder add:RShareSDKWhatsApp];
        [builder add:RShareSDKWechat];
        [builder add:RShareSDKSina];
        [builder add:RShareSDKQQ];
        [builder add:RShareSDKTumblr];
        [builder add:RShareSDKFacebook];
        [builder add:RShareSDKTwitter];
        [builder add:RShareSDKLine];
        [builder add:RShareSDKGooglePlus];
        [builder add:RShareSDKInstagram];
    }];
    
    [[RShareManager shared] registerPlatforms:p onConfiguration:^(RShareSDKPlatform platform, RRegister *obj) {
        switch (platform) {
            case RShareSDKPinterest:
                [obj connectPinterestByAppID: yourAppID appSecret: nil];
                break;
            case RShareSDKQQ:
                [obj connectQQByAppID:yourAppID appKey: yourKey];
                break;
                
            case RShareSDKSina:
                [obj connectSinaWeiboByAppKey: yourKey  appSecret:yourSecret];
                break;
            case RShareSDKWechat:
                [obj connectWechatByAppID: yourAppID appSecret:yourSecret];
                break;
            case RShareSDKTumblr:
                [obj conncetTumblrByConsumerKey: yourKey  consumerSecret: yourSecret];
                break;
            case RShareSDKFacebook:
                [obj connectFacebookByID:yourAppID secret:nil];
                break;
            case RShareSDKTwitter:
                [obj connectTwitterByConsumerKey:yourKey consumerSecret:yourSecret];
                
            default:
                break;
        }
    }];
    
    return YES;
}

```


**构建分享模型:**

以 ``RImageContent`` 为例:


```objc
RImageContent* content = RImageContent make:^(RImageContentBuilder *builder) {
     // ...   
}
```


**分享：**

以分享 ``RImageContent`` 为例:


```objc
[RShareManager shared] shareImageWithContent:content channel: channel from: context completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
     // ...   
}
```


**返回本应用:**


```objc
[[RShareManager shared]application:app openURL:url options:options];
```


