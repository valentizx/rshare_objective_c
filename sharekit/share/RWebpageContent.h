//
//  RWebpageContent.h
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RWebpageContentBuilder;

typedef void (^WebpageContentBuilderBlock) (RWebpageContentBuilder* builder);

@interface RWebpageContent : NSObject

@property (nonatomic, copy, readonly) NSString* webpageURL;
@property (nonatomic, copy, readonly) NSString* title;
@property (nonatomic, copy, readonly) NSString* quote;
@property (nonatomic, copy, readonly) NSString* hashTag;
@property (nonatomic, strong, readonly) UIImage* thumbImage;

+ (instancetype)make:(WebpageContentBuilderBlock)block;

@end

@interface RWebpageContentBuilder : NSObject

@property (nonatomic, copy) NSString* webpageURL;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* quote;
@property (nonatomic, copy) NSString* hashTag;
@property (nonatomic, strong) UIImage* thumbImage;

- (RWebpageContent*)build;

@end
