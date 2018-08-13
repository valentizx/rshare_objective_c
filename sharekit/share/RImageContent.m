//
//  RImageContent.m
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RImageContent.h"

@interface RImageContent()

@property (strong, nonatomic) UIImage* image;
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* quote;
@property (copy, nonatomic) NSString* imageURL;
@property (copy, nonatomic) NSString* webpageURL;

@end

@implementation RImageContent

+ (instancetype)make:(ImageContentBuilderBlock)block {
    
    RImageContentBuilder* builder = [[RImageContentBuilder alloc]init];
    block(builder);
    return [builder build];
}

@end


@implementation RImageContentBuilder

- (RImageContent *)build {
    
    RImageContent* content = [[RImageContent alloc]init];
    [content setValue:_image forKey:@"image"];
    [content setValue:_quote forKey:@"quote"];
    [content setValue:_imageURL forKey:@"imageURL"];
    [content setValue:_webpageURL forKey:@"webpageURL"];
    [content setValue:_title forKey:@"title"];
    
    return content;
}

@end

