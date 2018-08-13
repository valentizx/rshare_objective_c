//
//  RAudioContent.h
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RAudioContentBuilder;

typedef void (^AudioContentBuilderBlock) (RAudioContentBuilder* builder);

@interface RAudioContent : NSObject

@property (copy, nonatomic, readonly) NSString* audioStreamURL;
@property (copy, nonatomic, readonly) NSString* title;
@property (copy, nonatomic, readonly) NSString* quote;
@property (copy, nonatomic, readonly) NSString* audioWebpageURL;
@property (copy, nonatomic, readonly) UIImage* thumbImage;

+ (instancetype)make:(AudioContentBuilderBlock)block;

@end

@interface RAudioContentBuilder : NSObject

@property (nonatomic, copy) NSString* audioStreamURL;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* quote;
@property (nonatomic, copy) NSString* audioWebpageURL;
@property (copy, nonatomic) UIImage* thumbImage;

- (RAudioContent*)build;

@end

