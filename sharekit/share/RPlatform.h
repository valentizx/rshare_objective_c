//
//  RPlatform.h
//  sharekit
//
//  Created by valenti on 2018/5/30.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PlatformBuilder;

typedef NS_ENUM(NSInteger, RShareSDKPlatform) {
    RShareSDKWechat,
    RShareSDKFacebook,
    RShareSDKTwitter,
    RShareSDKSina,
    RShareSDKInstagram,
    RShareSDKQQ,
    RShareSDKTumblr,
    RShareSDKWhatsApp,
    RShareSDKLine,
    RShareSDKPinterest,
    RShareSDKGooglePlus,
    RShareSDKOther
};



typedef void (^PlatformBuilderBlock) (PlatformBuilder* builder);

@interface RPlatform : NSObject


@property (strong, nonatomic, readonly) NSArray<Class>* targets;

+ (BOOL) isInstalled:(RShareSDKPlatform)platform;

+ (RPlatform*)make:(PlatformBuilderBlock)block;

@end

@interface PlatformBuilder : NSObject


- (instancetype)add:(RShareSDKPlatform)platform;
- (RPlatform*)build;

@end
