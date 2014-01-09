//
//  NSTimer+Blocks.h
//  WangPan
//
//  Created by riven  on 13-11-29.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WriteFileWithAsset
+ (void)writeFileToPath:(NSString*)filePath andAsset:(ALAsset*)asset;

+ (BOOL)writeDataToPath:(NSString*)filePath andAsset:(ALAsset*)asset;
@end
