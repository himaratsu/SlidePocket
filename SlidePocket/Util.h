//
//  Util.h
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/13.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import "DDXML.h"

@interface Util : NSObject

- (NSString *)sha1:(NSString *)text;
- (time_t)unixtime;

+ (NSString *)nodeStringWithNode:(DDXMLNode *)node key:(NSString *)key;

@end
