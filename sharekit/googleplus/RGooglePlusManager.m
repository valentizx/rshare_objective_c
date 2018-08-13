//
//  RGooglePlusManager.m
//  share
//
//  Created by valenti on 2018/6/22.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RGooglePlusManager.h"
#import <SafariServices/SafariServices.h>

@interface RGooglePlusManager() <SFSafariViewControllerDelegate>

@end

@implementation RGooglePlusManager

static RGooglePlusManager* _instance = nil;

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

-(void)connect:(RConfiguration)c {
    c(RShareSDKGooglePlus, [RRegister shared]);
}

- (void)shareURL:(NSURL *)shareURL from:(UIViewController *)from {
    // Construct the Google+ share URL
    NSURLComponents* urlComponents = [[NSURLComponents alloc]
                                      initWithString:@"https://plus.google.com/share"];
    urlComponents.queryItems = @[[[NSURLQueryItem alloc]
                                  initWithName:@"url"
                                  value:[shareURL absoluteString]]];
    NSURL* url = [urlComponents URL];
    
    if ([SFSafariViewController class]) {
        // Open the URL in SFSafariViewController (iOS 9+)
        SFSafariViewController* controller = [[SFSafariViewController alloc]
                                              initWithURL:url];
        controller.delegate = self;
        [from presentViewController:controller animated:YES completion:nil];
    } else {
        // Open the URL in the device's browser
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
