//
//  NSTimer+Blocks.m
//  WangPan
//
//  Created by riven  on 13-11-29.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import "NSTimer+Blocks.h"

@implementation NSTimer (Blocks)
+ (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                 block:(void(^)())block
                               repeats:(BOOL)repeats
{
    [self scheduledTimerWithTimeInterval:interval
                                  target:self
                                selector:@selector(blockInvoke:)
                                userInfo:[block copy]
                                 repeats:repeats];
    return;
}

+ (void)blockInvoke:(NSTimer*)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
