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
#import "RLineManager.h"
#import "RPinterestManager.h"
#import "NSString+Extension.h"


@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) NSURL* localImageURL;
@property (weak, nonatomic) IBOutlet UILabel *videoURLLabel;



@property (strong, nonatomic) NSURL* videoAssetURL; // QQ 和 Facebook 可用 asset
@property (strong, nonatomic) NSURL* videoFileURL; // 新浪微博和 Instagram 可用 file


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
static NSString* _audioWebpageURL = @"http://url.cn/5tZF9KT";
// 网络图片链接
static NSString* _netImageURL = @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1509086430,2757737602&fm=11&gp=0.jpg";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _videoURLLabel.text = @"1, 若分享本地视频, 请先点击「获取视频URL」按钮; \n2, 在分享本地视频的过程中, 注意 demo 中 localVideoURL 和 localVideoURL2 的区别⚠️.";
    
    _image = [UIImage imageNamed:@"c_1"];
    
   
}

#pragma mark - Facebook -
- (IBAction)shareFbWeb:(id)sender {
    

    RFacebookManager* manager = [RFacebookManager shared];
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
    UIImage* image = [UIImage imageNamed:@"c"];
    [manager sharePhotos:@[image, image, image, image, image, image]
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


    [manager shareVideoWithLocalURL:_videoAssetURL from:self];
    
    
}
- (IBAction)shareFbMult:(id)sender {
}
#pragma mark - Twitter -
- (IBAction)shareTwWeb:(id)sender {
    RTwitterManager* manager = [RTwitterManager shared];
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
#pragma mark - Pinterest - 

- (IBAction)shareImgPin:(id)sender {
    RPinterestManager* manager = [RPinterestManager shared];
    [manager shareImageWithURL:_netImageURL webpageURL:_webpageURL onBoard:@"123" description:_description  from:self completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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
    [manager share:_image ];
}

- (IBAction)shareInsVid:(id)sender {
    RInstagramManager* manager = [RInstagramManager shared];
    [manager shareVideoWithLocalURL:_videoFileURL description:_description];
    
}


#pragma mark - Wehchat -
- (IBAction)shareTextWx:(id)sender {
    RWechatManager* manager = [RWechatManager shared];
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

    
    [manager shareMusicWithStreamURL:_audioStreamURL webpageURL:_audioWebpageURL title:_title description:_description thumbImage:_image scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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
    
    
    NSData* docData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list" ofType:@"docx"]];
    NSString* docExt = @"docx";
    
    NSData* videoData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ca" ofType:@"mp4"]];
    NSString* videoExt = @"mp4";
    
    NSData* pdfData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Liberation" ofType:@"pdf"]];
    NSString* pdfExt = @"pdf";
    
    [manager shareFileWithData:[NSData dataWithContentsOfFile:[_videoFileURL path]] extension:@"mp4" title:_title thumbImage:_image scene:Session completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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

    UIImage* image = [UIImage imageNamed:@"c"];
    [manager shareImage:@[image] text:_title toStory:NO completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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
    
    [manager shareVideoWithLocalURL:_videoFileURL text:_title toStory:NO completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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

    [manager shareWebpageWithURL:_webpageURL objectID:@"id" title:_title description:_description thumbImage:[UIImage imageNamed:@"c_2"] completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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
    [manager shareTextToQQ:_description scene:RQQShareAutomatic completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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
    [manager shareWebpageToQQWithURL:_webpageURL title:_title description:_description thumbImage:_image scene:RQQShareAutomatic completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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
    [manager shareAudioToQQWithStreamURL:_audioStreamURL title:_title description:_description thumbImage:_image webpageURL:_webpageURL scene:RQQShareAutomatic completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
        if (result == RShareResultSuccess) {
            NSLog(@"分享成功");
        } else if (result == RShareResultCancel){
            NSLog(@"分享取消");
        } else {
            NSLog(@"分享失败%@", errorInfo);
        }
    }];
}

- (IBAction)shareFileQq:(id)sender {
    NSData* videoData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ca" ofType:@"mp4"]];
    
    RQqManager* manager = [RQqManager shared];
    
    
    [manager shareFileToQQWithFileData:[NSData dataWithContentsOfFile:[_videoFileURL path]] fileName:[NSString stringWithFormat:@"%@.%@", [NSString randomFileName], @"mp4"] title:_title description:_description thumbImage:_image completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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
    UIImage* image = [UIImage imageNamed:@"c"];
   
    RQqManager* manager = [RQqManager shared];

    [manager shareImagesToQZone:@[image , image, image, image, image, image, image]  description:_description completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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

    [manager shareVideoToQZoneWithAssetURL:_videoAssetURL description:_description completion:^(RShareSDKPlatform platform, ShareResult result, NSString * _Nullable errorInfo) {
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
    [[RWhatsAppManager shared]shareImage:_image from:self];
}
#pragma mark - Google+ -
- (IBAction)shareUrlGplus:(id)sender {
    [[RGooglePlusManager shared]shareURL:[NSURL URLWithString:_webpageURL] from:self];
}
#pragma mark - Tumblr -
- (IBAction)shareImgTm:(id)sender {
    RTumblrManager* manager = [RTumblrManager shared];
   
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



#pragma mark - Line -
- (IBAction)shareTextLi:(id)sender {
    [[RLineManager shared] shareText:_description];
}

- (IBAction)shareImgLi:(id)sender {
    [[RLineManager shared] shareImage:_image];
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

    [picker dismissViewControllerAnimated:true completion:^{
    
        self-> _videoFileURL = [info objectForKey:UIImagePickerControllerMediaURL];
        self-> _videoAssetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        NSLog(@"💚💚💚💚💚💚💚💚💚💚💚💚%@", [self-> _videoFileURL absoluteString]);
        
        NSLog(@"♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️%@", [self-> _videoAssetURL absoluteString]);
        
        NSLog(@"💛💛💛💛💛💛💛💛💛💛💛💛后缀名%@", self->_videoFileURL.path.extension);
        
      
    }];
    

}

@end
