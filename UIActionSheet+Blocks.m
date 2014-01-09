//
//  UIActionSheet+Block.m
//  WangPan
//
//  Created by riven  on 13-11-29.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>

static NSString *handlerRunTimeAccosiationKey = @"ActionSheetViewBlocksDelegate";

@implementation UIActionSheet (Blocks)
- (void)showActionSheetViewFromView:(UIView *)view WithHandler:(UIActionSheetViewCallBackHandler)handler
{
    objc_setAssociatedObject(self, (__bridge  const void *)(handlerRunTimeAccosiationKey), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setDelegate:self];
    if ([view isKindOfClass:[UITabBar class]]) {
        [self showFromTabBar:(UITabBar *)view];
    }else if ([view isKindOfClass:[UIToolbar class]]){
        [self showFromToolbar:(UIToolbar *)view];
    }else{
        [self showInView:view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIActionSheetViewCallBackHandler completionHandler = objc_getAssociatedObject(self, (__bridge  const void *)(handlerRunTimeAccosiationKey));
    
    if (completionHandler != nil) {
        
        completionHandler(actionSheet, buttonIndex);
    }
}
@end
