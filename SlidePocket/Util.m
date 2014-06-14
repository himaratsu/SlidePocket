//
//  Util.m
//  SlidePocket
//
//  Created by 平松　亮介 on 2014/06/13.
//  Copyright (c) 2014年 rhiramat. All rights reserved.
//

#import "Util.h"

@implementation Util

- (NSString *)sha1:(NSString *)text
{
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


- (time_t)unixtime {
    return (time_t) [[NSDate date] timeIntervalSince1970];
}

+ (NSString *)nodeStringWithNode:(DDXMLNode *)node key:(NSString *)key {
    DDXMLNode *n = [node nodesForXPath:key error:nil][0];
    return n.stringValue;
}

@end
