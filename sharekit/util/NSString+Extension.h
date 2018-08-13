//
//  NSString+Extension.h
//  sharekit
//
//  Created by valenti on 2018/8/1.
//  Copyright © 2018 rex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

@property (nonatomic, copy, readonly) NSString* extension;


+ (NSString*)randomFileName;

@end
