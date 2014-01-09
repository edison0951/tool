//
//  UIActionSheet+Block.h
//  WangPan
//
//  Created by riven  on 13-11-29.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIActionSheetViewCallBackHandler)(UIActionSheet *actionSheet, NSInteger buttonIndex);

@interface UIActionSheet (Blocks)<UIActionSheetDelegate>

- (void)showActionSheetViewFromView:(UIView *)view WithHandler:(UIActionSheetViewCallBackHandler)handler;

@end
