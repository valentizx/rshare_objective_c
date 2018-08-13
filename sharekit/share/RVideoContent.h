//
//  RVideoContent.h
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RVideoContentBuilder;


typedef void (^VideoContentBuilderBlock)(RVideoContentBuilder* builder);

@interface RVideoContent : NSObject

@property (nonatomic, strong, readonly) NSURL* videoAssetURL;
@property (nonatomic, strong, readonly) NSURL* videoFileURL;
@property (nonatomic, strong, readonly) NSString* videoWebapgeURL;
@property (nonatomic, copy, readonly) NSString* title;
@property (nonatomic, copy, readonly) NSString* quote;
@property (nonatomic, strong, readonly) UIImage* thumbImage;

+ (instancetype)make:(VideoContentBuilderBlock)block;

@end


@interface RVideoContentBuilder : NSObject

@property (nonatomic, strong) NSURL* videoAssetURL;
@property (nonatomic, strong) NSURL* videoFileURL;
@property (nonatomic, strong) NSString* videoWebapgeURL;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* quote;
@property (nonatomic, strong) UIImage* thumbImage;

- (RVideoContent*)build;

@end
