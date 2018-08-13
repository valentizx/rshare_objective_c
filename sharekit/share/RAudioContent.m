//
//  RAudioContent.m
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RAudioContent.h"

@interface RAudioContent()

@property (copy, nonatomic) NSString* audioStreamURL;
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* quote;
@property (copy, nonatomic) NSString* audioWebpageURL;
@property (copy, nonatomic) UIImage* thumbImage;
@end

@implementation RAudioContent

+ (instancetype)make:(AudioContentBuilderBlock)block {
    
    RAudioContentBuilder* builder = [[RAudioContentBuilder alloc]init];
    block(builder);
    return [builder build];
}

@end

@interface RAudioContentBuilder()

@end

@implementation RAudioContentBuilder

- (RAudioContent*)build {
    
    RAudioContent* content = [[RAudioContent alloc]init];
    [content setValue:_audioStreamURL forKey:@"audioStreamURL"];
    [content setValue:_title forKey:@"title"];
    [content setValue:_quote forKey:@"quote"];
    [content setValue:_audioWebpageURL forKey:@"audioWebpageURL"];
    [content setValue:_thumbImage forKey:@"thumbImage"];
    
    return content;
}

@end
