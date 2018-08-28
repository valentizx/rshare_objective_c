//
//  RLineManager.m
//  sharekit
//
//  Created by valenti on 2018/7/23.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RLineManager.h"

@interface RLineManager()

@property(strong, nonatomic) NSURL* lineURL;

@end

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
- (void)connect:(RConfiguration)c {
    c (RShareSDKLine, [RRegister shared]);
}


static NSString* lineURLPrefix() {
    return @"line://msg/";
}

- (void)shareText:(NSString *)text {
    
    if(![RPlatform isInstalled:RShareSDKLine]) {
        NSLog(@"Line 未安装");
        return;
    }
    
    _lineURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@text/?%@", lineURLPrefix(),[text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    if ([[UIApplication sharedApplication] canOpenURL:_lineURL]) {
        [[UIApplication sharedApplication] openURL:_lineURL];
    }
    
}

- (void)shareImage:(UIImage *)image {
    if(![RPlatform isInstalled:RShareSDKLine]) {
        NSLog(@"Line 未安装");
        return;
    }
    UIPasteboard* p = [UIPasteboard generalPasteboard];
    [p setData:(UIImageJPEGRepresentation(image, 1)) forPasteboardType:@"public.jpeg"];
    _lineURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@image/%@", lineURLPrefix(),p.name]];
    if ([[UIApplication sharedApplication] canOpenURL: _lineURL]) {
        [[UIApplication sharedApplication] openURL: _lineURL];
    }
}

@end
