//
//  RWebpageContent.m
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RWebpageContent.h"


@interface RWebpageContent()

@property (nonatomic, copy) NSString* webpageURL;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* quote;
@property (nonatomic, copy) NSString* hashTag;
@property (nonatomic, strong) UIImage* thumbImage;

@end

@implementation RWebpageContent

+ (instancetype)make:(WebpageContentBuilderBlock)block {
    RWebpageContentBuilder* builder = [[RWebpageContentBuilder alloc]init];
    block(builder);
    return [builder build];
}

@end

@implementation RWebpageContentBuilder

- (RWebpageContent *)build {
    
    RWebpageContent* content = [[RWebpageContent alloc]init];
    [content setValue:_webpageURL forKey:@"webpageURL"];
    [content setValue:_title forKey:@"title"];
    [content setValue:_quote forKey:@"quote"];
    [content setValue:_hashTag forKey:@"hashTag"];
    [content setValue:_thumbImage forKey:@"thumbImage"];
    
    
    return content;
}

@end
