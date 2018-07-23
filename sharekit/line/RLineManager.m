//
//  RLineManager.m
//  sharekit
//
//  Created by valenti on 2018/7/23.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RLineManager.h"

@implementation RLineManager

static RLineManager* _instance = nil;

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
    
    if(![RPlatform isInstalled:RShareSDKLine]) {
        NSLog(@"Line 未安装");
        return;
    }
    
    NSString* textString =  [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString* urlString = [NSString stringWithFormat:@"line://msg/text/?%@", textString];
    
    NSURL* url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

- (void)shareImage:(UIImage *)image {
    if(![RPlatform isInstalled:RShareSDKLine]) {
        NSLog(@"Line 未安装");
        return;
    }
    UIPasteboard* p = [UIPasteboard generalPasteboard];
    [p setData:(UIImageJPEGRepresentation(image, 1)) forPasteboardType:@"public.jpeg"];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"line://msg/image/%@", p.name]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
