//
//  RQqHelper.m
//  sharekit
//
//  Created by valenti on 2018/6/22.
//  Copyright © 2018 rex. All rights reserved.
//

#import "RQqHelper.h"


@implementation RQqHelper

- (SendMessageToQQReq*)getTextReqToQQ:(NSString*)text
                                scene:(RQQShareScene)scene{
    QQApiTextObject* obj = [QQApiTextObject objectWithText:text];
    [obj setCflag:scene];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:obj];
    return req;
}

- (SendMessageToQQReq*)getImageReqToQQ:(UIImage*)image
                                 title:(NSString*)title
                           description:(NSString*)description
                                 scene:(RQQShareScene)scene{
    
    NSData* imgData = UIImageJPEGRepresentation(image, 1);
    QQApiImageObject* obj = [QQApiImageObject objectWithData:imgData previewImageData:imgData title:title description:description];
    [obj setCflag:scene];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:obj];
    return req;
    
}

- (SendMessageToQQReq *)getWebpageReqToQQ:(NSString *)webapgeURL
                                    title:(NSString *)title
                              description:(NSString *)description
                           thumbImageData:(NSData*)thumbImageData
                                    scene:(RQQShareScene)scene{
    
    QQApiNewsObject* obj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:webapgeURL] title:title description:description previewImageData:thumbImageData];
    [obj setCflag:scene];

    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:obj];
    return req;
}

- (SendMessageToQQReq*)getVideoReqToQQWithVideoURL:(NSString*)videoURL
                                             title:(NSString*)title
                                       description:(NSString*)description
                                    thumbImageData:(NSData*)thumbImageData
                                             scene:(RQQShareScene)scene{
    QQApiVideoObject* obj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:videoURL] title:title description:description previewImageData:thumbImageData];
    obj.flashURL = [NSURL URLWithString:videoURL];
    [obj setCflag:scene];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:obj];
    return req;
}

- (SendMessageToQQReq *)getAudioReqToQQWithAudioStreamURL:(NSString*)audioStreamURL
                                                    title:(NSString*)title
                                              description:(NSString*)description
                                           thumbImageData:(NSData*)thumbImageData
                                               webpageURL:(NSString*)webpageURL
                                                    scene:(RQQShareScene)scene{
    QQApiAudioObject* obj = [QQApiAudioObject objectWithURL:[NSURL URLWithString:webpageURL] title:title description:description previewImageData:thumbImageData];
    obj.flashURL = [NSURL URLWithString:audioStreamURL];
    [obj setCflag:(uint64_t)scene]; //obj unsignedIntValue
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:obj];
    return req;
}

- (SendMessageToQQReq *)getTextReqToQZone:(NSString *)text {
    QQApiImageArrayForQZoneObject *obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:nil title:text extMap:nil];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:obj];
    return req;
}

- (SendMessageToQQReq*)getImagesReqToQZone:(NSArray<UIImage *> *)images description:(NSString*)description{
    
    NSMutableArray<NSData*>* imageDatas = [NSMutableArray array];
    for (int i = 0; i < images.count; i ++) {
        [imageDatas addObject:UIImageJPEGRepresentation(images[i], 1)];
    }
    
    QQApiImageArrayForQZoneObject* obj =  [QQApiImageArrayForQZoneObject objectWithimageDataArray:imageDatas title:description extMap:nil];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:obj];
    return req;
    
}

- (SendMessageToQQReq *)getLocaleVideoReqToQZone:(NSURL *)videoAssetURL description:(NSString *)description {
    QQApiVideoForQZoneObject *obj = [QQApiVideoForQZoneObject objectWithAssetURL:[videoAssetURL absoluteString] title:description extMap:nil];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    return req;
}

@end
