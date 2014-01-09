//
//  NSTimer+Blocks.m
//  WangPan
//
//  Created by riven  on 13-11-29.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import "WriteFileWithAsset.h"

@implementation WriteFileWithAsset
+ (void)writeFileToPath:(NSString*)filePath andAsset:(ALAsset*)asset
{
    ALAssetRepresentation * rep = [asset defaultRepresentation];
    
    NSUInteger size = [rep size];
    const int bufferSize = 1024*1024; // or use 8192 size as read from other posts
    
    NSLog(@"Writing to %@",filePath);
    FILE* f = fopen([filePath cStringUsingEncoding:1], "wb+");
    if (f == NULL) {
        NSLog(@"Can not create tmp file.");
        return;
    }
    
    Byte * buffer = (Byte*)malloc(bufferSize);
    int read = 0, offset = 0, written = 0;
    NSError* err;
    if (size != 0) {
        do {
            read = [rep getBytes:buffer
                      fromOffset:offset
                          length:bufferSize
                           error:&err];
            written = fwrite(buffer, sizeof(char), read, f);
            NSLog(@"written==%d",written);
            offset += read;
        } while (read != 0);
    }
    fclose(f);
    free(buffer);
    return ;
}

+ (BOOL)writeDataToPath:(NSString*)filePath andAsset:(ALAsset*)asset
{
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (!handle) {
        return NO;
    }
    static const NSUInteger BufferSize = 1024*1024;
    
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    uint8_t *buffer = calloc(BufferSize, sizeof(*buffer));
    NSUInteger offset = 0, bytesRead = 0;
    
    do {
        @try {
            bytesRead = [rep getBytes:buffer fromOffset:offset length:BufferSize error:nil];
            [handle writeData:[NSData dataWithBytesNoCopy:buffer length:bytesRead freeWhenDone:NO]];
            offset += bytesRead;
        } @catch (NSException *exception) {
            free(buffer);
            
            return NO;
        }
    } while (bytesRead > 0);
    
    free(buffer);
    return YES;
}

@end
