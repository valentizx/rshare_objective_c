//
//  RWhatsAppManager.m
//  sharekit
//
//  Created by valenti on 2018/6/25.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RWhatsAppManager.h"
#import "RPlatform.h"

@interface RWhatsAppManager()<UIDocumentInteractionControllerDelegate>

@property(nonatomic, strong) UIDocumentInteractionController* dc;
@property (nonatomic, strong) UIViewController* from;

@end

@implementation RWhatsAppManager

static RWhatsAppManager* _instance = nil;

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

- (void)shareText:(NSString *)text {
    
    if(![RPlatform isInstalled:RShareSDKWhatsApp]) {
        NSLog(@"WhatsApp 未安装");
        return;
    }
    
    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@", text];
    NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
}

- (void)shareImage:(UIImage *)image from:(UIViewController *)from {
    
    if(![RPlatform isInstalled:RShareSDKWhatsApp]) {
        NSLog(@"WhatsApp 未安装");
        return;
    }
    _from = from;
    /**
     * 调用 UIDocumentInteractionController 分享.
     **/
    NSString* savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.jpg"];
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:savePath atomically:YES];
    
    NSURL *fileURL = [NSURL fileURLWithPath:savePath];
    self.dc = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.dc.delegate = self;
    [self.dc setUTI:@"net.whatsapp.image"];
    [self.dc presentOpenInMenuFromRect:from.view.bounds inView:from.view animated:YES];
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
