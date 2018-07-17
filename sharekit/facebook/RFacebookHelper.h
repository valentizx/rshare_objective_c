//
//  RFacebookHelper.h
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "RShare.h"

@interface RFacebookHelper : NSObject

+ (FBSDKShareDialogMode)getMode:(Mode)mode;

+ (FBSDKShareLinkContent*)getLinkContent:(NSString*)link
                                   quote:(NSString*)quote
                                 hashTag:(NSString*)hashTag;

+ (FBSDKSharePhotoContent*)getPhotosContent:(NSArray<UIImage*>*)photos;

+ (FBSDKShareVideoContent*)getVideoContent:(NSURL*)localVideoURL;


@end
