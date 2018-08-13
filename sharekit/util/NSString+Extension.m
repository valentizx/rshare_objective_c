//
//  NSString+Extension.m
//  sharekit
//
//  Created by valenti on 2018/8/1.
//  Copyright © 2018 rex. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)extension {
    
    return [[self componentsSeparatedByString:@"."] lastObject];
}

+ (NSString*)randomFileName  {
    
    NSDate* date = [NSDate date];
    NSString* stampString = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return stampString;
    
}

@end
