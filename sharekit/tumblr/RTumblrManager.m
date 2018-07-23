//
//  RTumblrManager.m
//  sharekit
//
//  Created by valenti on 2018/6/26.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RTumblrManager.h"
#import "FlurryTumblr.h"
#import "FlurryTumblrDelegate.h"



@interface RTumblrManager()<FlurryTumblrDelegate>



@property (copy, nonatomic) share share;

@end


@implementation RTumblrManager

static RTumblrManager* _instance = nil;

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

- (void)sdkInitializeByConsumerKey:(NSString *)key consumerSecret:(NSString *)secret {

    [FlurryTumblr setConsumerKey:key consumerSecret:secret];
    [FlurryTumblr setDelegate:self];
}

- (void)dealloc {
    [FlurryTumblr setDelegate:nil];
}


- (void)shareImageWithURL:(NSString *)imageURL
              description:(NSString *)description
               webpageURL:(NSString *)webpageURL
                     from:(UIViewController *)from
                completion:(share)share {
    _share = share;
    FlurryImageShareParameters* param = [[FlurryImageShareParameters alloc]init];
    param.imageURL = imageURL;
    param.imageCaption = description;
    param.webLink = webpageURL;
    [FlurryTumblr post:param presentingViewController:from];
    
}

- (void)shareText:(NSString *)text
            title:(NSString *)title
       webpageURL:(NSString *)webpageURL
             from:(UIViewController *)from
        completion:(share)share {
    _share = share;
    FlurryTextShareParameters* param = [[FlurryTextShareParameters alloc]init];
    param.text = text;
    param.title = title;
    [FlurryTumblr post:param presentingViewController:from];
}

#pragma mark - FlurryTumblrDelegate -

- (void)flurryTumblrPostSuccess {
    if (_share) {
        _share(RShareSDKTumblr, RShareResultSuccess, nil);
    }
    
}
- (void)flurryTumblrPostError:(NSError *)error errorType:(FlurryTumblrErrorType)errorType {
    if (_share) {
        if (errorType == FlurryTumblrUserCanceled) {
            _share(RShareSDKTumblr, RShareResultCancel, nil);
        } else {
            _share(RShareSDKTumblr, RShareResultFailure, error.localizedDescription);
        }
    }
}

@end
