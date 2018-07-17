//
//  RPlatform.h
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RShareSDKPlatform) {
    RShareSDKWechat,
    RShareSDKFacebook,
    RShareSDKTwitter,
    RShareSDKSina,
    RShareSDKInstagram,
    RShareSDKQQ,
    RShareSDKTumblr,
    RShareSDKWhatsApp,
    RShareSDKOther
};

@interface RPlatform : NSObject

+ (BOOL) isInstalled:(RShareSDKPlatform)platform;

@end
