//
//  RInstagramManager.m
//  sharekit
//
//  Created by valenti on 2018/6/1.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RInstagramManager.h"
#import "RPlatform.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface RInstagramManager()<UIDocumentInteractionControllerDelegate>

@property(nonatomic, strong) UIDocumentInteractionController* dc;
@property (nonatomic, strong) UIViewController* from;

@end

@implementation RInstagramManager

static RInstagramManager* _instance = nil;

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
static NSURL* instagramLibraryURL() {
    NSString *str = [NSString stringWithFormat:@"instagram://library?AssetPath=%@", @""];
    return [NSURL URLWithString:str];
}

- (void)share:(UIImage *)image mode:(Mode)mode from:(UIViewController*)from {
    
    if (![RPlatform isInstalled:RShareSDKInstagram]) {
        NSLog(@"Instagram 未安装");
        return;
    }
    
    if (mode == ShareModeSystem) {
    
        _from = from;
        /**
         * 调用 UIDocumentInteractionController 分享.
         **/
        NSString *savePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:savePath atomically:YES];
        
        NSURL *fileURL = [NSURL fileURLWithPath:savePath];
        self.dc = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        self.dc.delegate = self;
        [self.dc setUTI:@"com.instagram.exclusivegram"];
        [self.dc presentOpenInMenuFromRect:from.view.bounds inView:from.view animated:YES];
        
    } else {
        /**
         * 现保存到系统相册, 再跳转 Instagram 应用分享.
         **/
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }
}

- (void)shareVideoWithLocalURL:(NSURL *)localeVideoURL
                    description:(NSString *)description
                           from:(UIViewController *)from {
    
    
    UISaveVideoAtPathToSavedPhotosAlbum(localeVideoURL.path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);

}

/**
 * 视频保存成功.
 */
- (void)video:(NSString *)path didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramLibraryURL()]) {
        [[UIApplication sharedApplication] openURL:instagramLibraryURL()];
    }
}
/**
 * 照片保存成功.
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if ([[UIApplication sharedApplication] canOpenURL:instagramLibraryURL()]) {
        [[UIApplication sharedApplication] openURL:instagramLibraryURL()];
    }
}
#pragma mark - UIDocumentInteractionController -
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return _from;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return _from.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return _from.view.bounds;
}


@end
