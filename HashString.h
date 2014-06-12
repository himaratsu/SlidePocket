//
//  HashString.h
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/12.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

@interface HashString : NSObject

- (NSString *)sha256:(NSString *)text;
- (NSString *)sha1:(NSString *)text;
- (time_t)unixtime;

@end