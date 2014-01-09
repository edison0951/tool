//
//  NSMutableArray+Filter.m
//  WangPan
//
//  Created by riven  on 13-8-2.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import "NSMutableArray+Filter.h"

@implementation NSMutableArray (Filter)

- (void)filterStringObject:(NSString *)filterString
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", filterString];
    [self filterUsingPredicate:predicate];
}

@end
