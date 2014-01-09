//
//  NSTimer+Blocks.h
//  WangPan
//
//  Created by riven  on 13-11-29.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Blocks)
+ (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                 block:(void(^)())block
                               repeats:(BOOL)repeats;
@end
