//
//  RTextContent.h
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RTextContentBuilder;

typedef void (^TextContentBuilderBlock)(RTextContentBuilder* builder);

@interface RTextContent : NSObject
@property (nonatomic, copy, readonly) NSString* body;
@property (nonatomic, copy, readonly) NSString* title;
@property (nonatomic, copy, readonly) NSString* webpageURL;

+ (instancetype)make:(TextContentBuilderBlock)block;

@end

@interface RTextContentBuilder : NSObject;

@property (nonatomic, copy) NSString* body;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* webpageURL;


- (RTextContent*)build;

@end
