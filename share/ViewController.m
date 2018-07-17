//
//  ViewController.m
//  share
//
//  Created by valenti on 2018/5/9.
//  Copyright © 2018 rex. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "RFacebookManager.h"
#import "RTwitterManager.h"
#import "RInstagramManager.h"
#import "RWechatManager.h"
#import "RSinaWeiboManager.h"
#import "RQqManager.h"
#import "RWhatsAppManager.h"
#import "RGooglePlusManager.h"
#import "RTumblrManager.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) NSURL* localImageURL;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videoURLLabel;



@property (strong, nonatomic) NSURL* localVideoURL; // QQ 和 Facebook 可用
@property (strong, nonatomic) NSURL* localVideoURL2; // 新浪微博 和 Instagram 可用

@property (strong, nonatomic) PHAsset* asset;

@end

@implementation ViewController

// 网页
static NSString* _webpageURL = @"https://www.nytimes.com/2018/05/04/arts/music/playlist-christina-aguilera-kanye-west-travis-scott-dirty-projectors.html";
// 话题
static NSString* _hashTag = @"#liberation";
// 网页描述
static NSString* _description = @"流行天后 Christina Aguilera 时隔六年回归全新录音室专辑「Liberation」于 2018 年 6 月 15 日发布.";
// 标题
static NSString* _title = @"Liberation";

// 视频网页
static NSString* _videoWebpageURL = @"https://www.youtube.com/watch?v=DSRSgMp5X1w";
// 音频流链接
static NSString* _audioStreamURL = @"http://10.136.9.109/fcgi-bin/fcg_music_get_playurl.fcg?song_id=1234&redirect=0&filetype=mp3&qqmusic_fromtag=15&app_id=100311325&app_key=b233c8c2c8a0fbee4f83781b4a04c595&device_id=1234";
// 音频网页链接
static NSString* _adudioWebpageURL = @"http://url.cn/5tZF9KT";
// 网络图片链接
static NSString* _netImageURL = @"http://photocdn.sohu.com/20151211/Img430920125.jpg";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _videoURLLabel.text = @"1, 若分享本地视频, 请先点击「获取视频URL」按钮; \n2, 在分享本地视频的过程中, 注意 demo 中 localVideoURL 和 localVideoURL2 的区别⚠️.";
    
    _image = [UIImage imageNamed:@"c_1"];
    _localVideoURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"apm" ofType:@"mov"]];
    
    NSData* imageData = UIImageJPEGRepresentation(_image, 1);
    [imageData writeToFile:[self getLocaleImgPath] atomically:true];
}

- (NSString*)getLocaleImgPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString* path = [NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject], @"/share"];
    
    [manager createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
    return [path stringByAppendingPathComponent:@"tmpimage.jpg"];
}


#pragma mark - Facebook -
- (IBAction)shareFbWeb:(id)sender {
    

    RFacebookManager* manager = [RFacebookManager shared];
    [manager sdkInitializeByID:@"234270717151331" secret:nil];
    [manager shareWebpageWithURL:_webpageURL
                           quote:_description
                         hashTag:_hashTag
                            from:self
                            mode:ShareModeNative
                      completion:^(RShareSDKPlatform platform, ShareResult result, NSString *errorInfo) {
                          if (result == RShareResultSuccess) {
                              NSLog(@"分享成功");
                          } else if (result == RShareResultCancel){
                              NSLog(@"分享取消");
                          } else {
                              NSLog(@"分享失败%@", errorInfo);
                            
                          }
    }];
}
- (IBAction)shareFbPhotos:(id)sender {
    RFacebookManager* manager = [RFacebookManager shared];
    [manager sdkInitializeByID:@"234270717151331" secret:nil];
    UIImage* image1 = [UIImage imageNamed:@"affleck"];
    UIImage* image2 = [UIImage imageNamed:@"affleck"];
    UIImage* image3 = [UIImage imageNamed:@"affleck"];
    UIImage* image4 = [UIImage imageNamed:@"affleck"];
    UIImage* image5 = [UIImage imageNamed:@"affleck"];
    UIImage* image6 = [UIImage imageNamed:@"affleck"];
    UIImage* image7 = [UIImage imageNamed:@"affleck"];
    [manager sharePhotos:@[image1, image2, image3, image4, image5, image6]
                    from:self
              completion:^(RShareSDKPlatform platform, ShareResult result, NSString *errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
            
        }
    }];
}
- (IBAction)shareFbVid:(id)sender {

    
    RFacebookManager* manager = [RFacebookManager shared];
    [manager sdkInitializeByID:@"234270717151331" secret:nil];


    [manager shareVideoWithLocalURL:_localVideoURL from:self];
    
    
}
- (IBAction)shareFbMult:(id)sender {
}
#pragma mark - Twitter -
- (IBAction)shareTwWeb:(id)sender {
    RTwitterManager* manager = [RTwitterManager shared];
    [manager sdkInitializeByConsumerKey:@"cA72pVIFxOOWWfT8t9sFLcNUS" consumerSecret:@"Rc9ornOaSWTFYqFzxDIEtIcsaWoxRcVGJs6U71kAjhHcGHyEZi"];
    [manager shareWithWebpageURL:_webpageURL text:_description image:_image from:self completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
            
        }
    }];
    
}


#pragma mark - Instagram -
- (IBAction)shareInsPh:(id)sender {
    RInstagramManager* manager = [RInstagramManager shared];
    [manager share:_image mode:ShareModeNative from:self];
}
- (IBAction)shareInsPhSys:(id)sender {
    RInstagramManager* manager = [RInstagramManager shared];
    [manager share:_image mode:ShareModeSystem from:self];
}
- (IBAction)shareInsVid:(id)sender {
    RInstagramManager* manager = [RInstagramManager shared];
    [manager shareVideoWithLocalURL:_localVideoURL2 description:_description from:self];
    
}


#pragma mark - Wehchat -
- (IBAction)shareTextWx:(id)sender {
    RWechatManager* manager = [RWechatManager shared];
    [manager sdkInitializeByAppID:@"wxd471bcf3a21c7c4a" appSecret:@"f71570ef272a5a6699decb264be9cdbb"];
    [manager shareText:_description scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
            
        }
    }];
}
- (IBAction)sharePhWx:(id)sender {
    RWechatManager* manager = [RWechatManager shared];
    [manager sdkInitializeByAppID:@"wxd471bcf3a21c7c4a" appSecret:@"f71570ef272a5a6699decb264be9cdbb"];
    [manager shareImage:_image scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
            
        }
    }];
}
- (IBAction)shareWebWx:(id)sender {
    RWechatManager* manager = [RWechatManager shared];
    [manager sdkInitializeByAppID:@"wxd471bcf3a21c7c4a" appSecret:@"f71570ef272a5a6699decb264be9cdbb"];
    [manager shareWebpageWithURL:_webpageURL title:_title description:_description thumbImage:_image scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)shareVideoWx:(id)sender {
    RWechatManager* manager = [RWechatManager shared];
    [manager sdkInitializeByAppID:@"wxd471bcf3a21c7c4a" appSecret:@"f71570ef272a5a6699decb264be9cdbb"];
    [manager shareVideoWithURL:_videoWebpageURL title:_title description:_description thumbImage:_image scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)shareMsicWx:(id)sender {
    RWechatManager* manager = [RWechatManager shared];
    [manager sdkInitializeByAppID:@"wxd471bcf3a21c7c4a" appSecret:@"f71570ef272a5a6699decb264be9cdbb"];
    
    [manager shareMusicWithStreamURL:_audioStreamURL webpageURL:_adudioWebpageURL title:_title description:_description thumbImage:_image scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)shareMiniProgrWx:(id)sender {
    RWechatManager* manager = [RWechatManager shared];
    [manager sdkInitializeByAppID:@"wxd471bcf3a21c7c4a" appSecret:@"f71570ef272a5a6699decb264be9cdbb"];
    
    [manager shareMiniProgramWithUserName:@"gh_d43f693ca31f" path:@"pages/play/index?cid=fvue88y1fsnk4w2&ptag=vicyao&seek=3219" type:RWXMiniProgramTypeRelease webpageURL:_webpageURL title:_title description:_description thumbImage:_image scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}

- (IBAction)shareFileWx:(id)sender {
    RWechatManager* manager = [RWechatManager shared];
    [manager sdkInitializeByAppID:@"wxd471bcf3a21c7c4a" appSecret:@"f71570ef272a5a6699decb264be9cdbb"];
    
    
    NSData* docData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list" ofType:@"docx"]];
    NSString* docExt = @"docx";
    
    NSData* videoData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ca" ofType:@"mp4"]];
    NSString* videoExt = @"mp4";
    
    NSData* pdfData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Liberation" ofType:@"pdf"]];
    NSString* pdfExt = @"pdf";
    
    [manager shareFileWithData:docData extention:docExt title:_title thumbImage:_image scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
    
}



#pragma mark - 微博 -
- (IBAction)shareTextWb:(id)sender {
    RSinaWeiboManager* manager = [RSinaWeiboManager shared];
    [manager sdkInitializeByAppKey:@"3026908911" appSecret:@"91fbafc7be7510c0ac5d73883c655db1"];
    [manager shareText:_description completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
    
}
- (IBAction)sharePhWb:(id)sender {
    RSinaWeiboManager* manager = [RSinaWeiboManager shared];
    [manager sdkInitializeByAppKey:@"3026908911" appSecret:@"91fbafc7be7510c0ac5d73883c655db1"];
    UIImage* image1 = [UIImage imageNamed:@"cover1"];
    UIImage* image2 = [UIImage imageNamed:@"cover2"];
    UIImage* image3 = [UIImage imageNamed:@"cover3"];
    UIImage* image4 = [UIImage imageNamed:@"cover4"];
    UIImage* image5 = [UIImage imageNamed:@"cover5"];
    UIImage* image6 = [UIImage imageNamed:@"cover6"];
    UIImage* image7 = [UIImage imageNamed:@"cover7"];
    UIImage* image8 = [UIImage imageNamed:@"cover8"];
    UIImage* image9 = [UIImage imageNamed:@"cover9"];
    [manager shareImage:@[image1, image2, image3, image4, image5, image6, image7, image8, image9] text:_title toStory:NO completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)shareVidWb:(id)sender {
    RSinaWeiboManager* manager = [RSinaWeiboManager shared];
    [manager sdkInitializeByAppKey:@"3026908911" appSecret:@"91fbafc7be7510c0ac5d73883c655db1"];
    
    
    NSLog(@"⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️%@", _localVideoURL);
    
    [manager shareVideoWithLocalURL:_localVideoURL2 videoAsset:_asset text:_title toStory:NO completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
    
}

- (IBAction)shareWebWb:(id)sender {
    RSinaWeiboManager* manager = [RSinaWeiboManager shared];
    [manager sdkInitializeByAppKey:@"3026908911" appSecret:@"91fbafc7be7510c0ac5d73883c655db1"];
    [manager shareWebpageWithURL:_webpageURL objectID:@"id" title:_title description:_description thumbImage:[UIImage imageNamed:@"logo"] completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
#pragma mark - QQ -
- (IBAction)shareTextQq:(id)sender {
    RQqManager* manager = [RQqManager shared];
    [manager sdkInitializeByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
    [manager shareTextToQQ:_title scene:RQQShareDataline completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}

- (IBAction)shareImgQq:(id)sender {
    RQqManager* manager = [RQqManager shared];
    [manager sdkInitializeByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
    [manager shareImageToQQ:_image title:_title description:_description scene:RQQShareAutomatic completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
        
    }];
}
- (IBAction)shareWebQq:(id)sender {
    
    RQqManager* manager = [RQqManager shared];
    [manager sdkInitializeByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
    [manager shareWebpageToQQWithURL:_webpageURL title:_title description:_description thumbImage:_image scene:RQQShareDataline completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
    
}
- (IBAction)shareVidQq:(id)sender {
    
    RQqManager* manager = [RQqManager shared];
    [manager sdkInitializeByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
    [manager shareVideoToQQWithURL:_videoWebpageURL title:_title description:_description thumbImage:_image scene:RQQShareDataline completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)shareAudQq:(id)sender {
    RQqManager* manager = [RQqManager shared];
    [manager sdkInitializeByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
    [manager shareAudioToQQWithStreamURL:_audioStreamURL title:_title description:_description thumbImage:_image webpageURL:_webpageURL scene:RQQShareDataline completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)shareTextQz:(id)sender {
    
    RQqManager* manager = [RQqManager shared];
    [manager sdkInitializeByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
    [manager shareTextToQZone:_description completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)shareImgsQz:(id)sender {
    UIImage* image1 = [UIImage imageNamed:@"cover1"];
    UIImage* image2 = [UIImage imageNamed:@"cover2"];
    UIImage* image3 = [UIImage imageNamed:@"cover3"];
    UIImage* image4 = [UIImage imageNamed:@"cover4"];
    UIImage* image5 = [UIImage imageNamed:@"cover5"];
    UIImage* image6 = [UIImage imageNamed:@"cover6"];
    UIImage* image7 = [UIImage imageNamed:@"cover7"];
    UIImage* image8 = [UIImage imageNamed:@"cover8"];
    UIImage* image9 = [UIImage imageNamed:@"cover9"];
    RQqManager* manager = [RQqManager shared];
    [manager sdkInitializeByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
    [manager shareImagesToQZone:@[image1, image2, image3, image4, image5, image6, image7, image8, image9]  description:_description completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)shareVidQz:(id)sender {
    
    RQqManager* manager = [RQqManager shared];
    [manager sdkInitializeByAppID:@"1106463933" appKey:@"4WSrOXMoeFMDNR2k"];
    [manager shareVideoToQZoneWithAssetURL:_localVideoURL description:_description completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
#pragma mark - WhatsApp -
- (IBAction)shareTextWsa:(id)sender {
    [[RWhatsAppManager shared]shareText:_description];
}
- (IBAction)shareImgWsa:(id)sender {
    [[RWhatsAppManager shared]shareImage:_image from:self];;
}
#pragma mark - Google+ -
- (IBAction)shareUrlGplus:(id)sender {
    [[RGooglePlusManager shared]shareURL:[NSURL URLWithString:_webpageURL] from:self];
}
#pragma mark - Tumblr -
- (IBAction)shareImgTm:(id)sender {
    RTumblrManager* manager = [RTumblrManager shared];
    [manager sdkInitializeByConsumerKey:@"ZJIv7SNrKMcct5tdQy7rzzsv3b0pTxBNYWkV548LgbIDIwsnPt" consumerSecret:@"7jsraXodsVSeMHMLtHg5FYyporapRTf2ahJFK2tsnV4x0fYjse"];
    [manager shareImageWithURL:_netImageURL description:_description webpageURL:_webpageURL from:self completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
    
}
- (IBAction)shareTextTm:(id)sender {
    RTumblrManager* manager = [RTumblrManager shared];
    [manager sdkInitializeByConsumerKey:@"ZJIv7SNrKMcct5tdQy7rzzsv3b0pTxBNYWkV548LgbIDIwsnPt" consumerSecret:@"7jsraXodsVSeMHMLtHg5FYyporapRTf2ahJFK2tsnV4x0fYjse"];
    [manager shareText:_description title:_title webpageURL:_webpageURL from:self completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}
- (IBAction)getVideoURL:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", @"public.video", nil];
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:^{}];
    
}

#pragma mark - 代理 -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
     __block NSURL* videoURL = [[NSURL alloc]init];
    
    if (@available(iOS 11, *)) {
       
        _asset = [info objectForKey:UIImagePickerControllerPHAsset];
        
        
        PHImageManager *manager = [PHImageManager defaultManager];
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        
       
    
        [manager requestAVAssetForVideo:_asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            
            NSURL *url = urlAsset.URL;
            
            videoURL = url;
            
        }];

    } else {
        _localVideoURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    }
    
    [picker dismissViewControllerAnimated:true completion:^{
    
        self-> _localVideoURL2 = [info objectForKey:UIImagePickerControllerMediaURL];
        self-> _localVideoURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        NSLog(@"💚💚💚💚💚💚💚💚💚💚💚💚%@", [self-> _localVideoURL2 absoluteString]);
        
        NSLog(@"♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️%@", [self-> _localVideoURL absoluteString]);
    }];
}

@end
