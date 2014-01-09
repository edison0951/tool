//
//  AlertViewBlocks.h
//  multipleAlertViews
//
//  Created by abdus on 2/14/13.
//  Copyright (c) 2013 abdus. All rights reserved.
//
#import <UIKit/UIKit.h>

//define this handler outside the declaration as in category we cannot add instance variables, in .m file we will associate this with self
typedef void(^UIActionAlertViewCallBackHandler)(UIAlertView *alertView, NSInteger buttonIndex);

//@interface AlertViewBlocks : NSObject
@interface UIAlertView (Blocks) <UIAlertViewDelegate>

- (void)showAlerViewWithHandler:(UIActionAlertViewCallBackHandler)handler;

@end
