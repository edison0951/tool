//
//  NSString+URLEncoding.m
//  WangPan
//
//  Created by riven  on 13-4-18.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)URLEncodedString
{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (__bridge CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8);
    return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (__bridge CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
    return result;
}
@end
