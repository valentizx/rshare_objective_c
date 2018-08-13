//
//  RTextContent.m
//  sharekit
//
//  Created by valenti on 2018/7/31.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RTextContent.h"

@interface RTextContent()

@property (nonatomic, copy) NSString* body;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* webpageURL;

@end

@implementation RTextContent

+ (instancetype)make:(TextContentBuilderBlock)block {
    RTextContentBuilder* builder = [[RTextContentBuilder alloc]init];
    block(builder);
    return [builder build];
}

@end

@implementation RTextContentBuilder

- (RTextContent *)build {
    
    RTextContent* content = [[RTextContent alloc]init];
    [content setValue:_body forKey:@"body"];
    [content setValue:_title forKey:@"title"];
    [content setValue:_webpageURL forKey:@"webpageURL"];
    return content;
}

@end
