//
//  RImageContent.h
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RImageContentBuilder;

typedef void (^ImageContentBuilderBlock) (RImageContentBuilder* builder);

@interface RImageContent : NSObject

@property (strong, nonatomic, readonly) UIImage* image;
@property (copy, nonatomic, readonly) NSString* title;
@property (copy, nonatomic, readonly) NSString* quote;
@property (copy, nonatomic, readonly) NSString* imageURL;
@property (copy, nonatomic, readonly) NSString* webpageURL;

+ (instancetype)make:(ImageContentBuilderBlock)block;

@end


@interface RImageContentBuilder : NSObject

@property (strong, nonatomic) UIImage* image;
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* quote;
@property (copy, nonatomic) NSString* imageURL;
@property (copy, nonatomic) NSString* webpageURL;

- (RImageContent*)build;

@end



