//
//  RVideoContent.m
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RVideoContent.h"


@interface RVideoContent()

@property (nonatomic, strong) NSURL* videoAssetURL;
@property (nonatomic, strong) NSURL* videoFileURL;
@property (nonatomic, strong) NSString* videoWebapgeURL;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* quote;
@property (nonatomic, strong) UIImage* thumbImage;

@end


@implementation RVideoContent

+ (instancetype)make:(VideoContentBuilderBlock)block {
    RVideoContentBuilder* builer = [[RVideoContentBuilder alloc]init];
    block(builer);
    return [builer build];
}

@end


@implementation RVideoContentBuilder

- (RVideoContent *)build {
    
    RVideoContent* content = [[RVideoContent alloc]init];
    [content setValue:_videoAssetURL forKey:@"videoAssetURL"];
    [content setValue:_videoFileURL forKey:@"videoFileURL"];
    [content setValue:_videoWebapgeURL forKey:@"videoWebapgeURL"];
    [content setValue:_title forKey:@"title"];
    [content setValue:_quote forKey:@"quote"];
    [content setValue:_thumbImage forKey:@"thumbImage"];
    return content;
}

@end
