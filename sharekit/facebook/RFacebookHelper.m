//
//  RFacebookHelper.m
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RFacebookHelper.h"

@implementation RFacebookHelper

+ (FBSDKShareDialogMode)getMode:(Mode)mode {
    if (mode == ShareModeAutomatic) {
        return FBSDKShareDialogModeAutomatic;
    } else if (mode == ShareModeNative) {
        return FBSDKShareDialogModeNative;
    } else if (mode == ShareModeSheet) {
        return FBSDKShareDialogModeShareSheet;
    } else if (mode == ShareModeWeb) {
        return FBSDKShareDialogModeWeb;
    } else if (mode == ShareModeBrowser) {
        return FBSDKShareDialogModeBrowser;
    } else if (mode == ShareModeFeed) {
        return FBSDKShareDialogModeFeedWeb;
    } else{
        return FBSDKShareDialogModeFeedBrowser;
    }
}

+ (FBSDKShareLinkContent*)getLinkContent:(NSString *)webpageURL
                                   quote:(NSString *)quote
                                 hashTag:(NSString *)hashTag {
    FBSDKShareLinkContent* content = [[FBSDKShareLinkContent alloc]init];
    content.contentURL = [NSURL URLWithString:webpageURL];
    content.quote = quote;
    if (hashTag) {
        content.hashtag = [FBSDKHashtag hashtagWithString:hashTag];
    }
    
    return content;
}

+ (FBSDKSharePhotoContent *)getPhotosContent:(NSArray<UIImage *> *)photos {
    
    NSMutableArray<FBSDKSharePhoto*>* sharePhotos = [NSMutableArray array];
    FBSDKSharePhotoContent* content = [[FBSDKSharePhotoContent alloc]init];
    for (UIImage* image in photos) {
        FBSDKSharePhoto* photo = [FBSDKSharePhoto photoWithImage:image userGenerated:YES];
        [sharePhotos addObject:photo];
    }
    content.photos = sharePhotos;
    return content;
}

+ (FBSDKShareVideoContent*)getVideoContent:(NSURL*)localVideoURL {
    FBSDKShareVideo* video = [[FBSDKShareVideo alloc]init];
    video.videoURL = localVideoURL;
    
    FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
    content.video = video;
    return content;
}

@end
