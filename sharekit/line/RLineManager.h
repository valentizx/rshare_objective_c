//
//  RLineManager.h
//  sharekit
//
//  Created by valenti on 2018/7/23.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RShare.h"

@interface RLineManager : RShare

+ (instancetype)shared;

- (void)shareText:(NSString*)text;

- (void)shareImage:(UIImage*)image;

@end
