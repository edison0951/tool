//
// NSString+MD5.m
// Originally created for MyFile
//
// Created by Árpád Goretity, 2011. Some infos were grabbed from StackOverflow.
// Released into the public domain. You can do whatever you want with this within the limits of applicable law (so nothing nasty!).
// I'm not responsible for any damage related to the use of this software. There's NO WARRANTY AT ALL.
//

#import "NSString+MD5.h"

#define DEFAULT_READ_LENGTH 8192

@implementation NSString (MD5)

+ (NSString *)stringWithMD5OfFile:(NSString *)path{

	NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
	if (handle == nil) {
		return nil;
	}
	
	CC_MD5_CTX md5;
	CC_MD5_Init (&md5);
	
	BOOL done = NO;
	
	while (!done) {
	
		NSData *fileData = [[NSData alloc] initWithData: [handle readDataOfLength:DEFAULT_READ_LENGTH]];
		CC_MD5_Update (&md5, [fileData bytes], [fileData length]);
		
		if ([fileData length] == 0) {
			done = YES;
		}
        //[handle seekToFileOffset:]
	}
	[handle closeFile];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final (digest, &md5);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[output appendFormat:@"%02x",digest[i]];
	}
	return output;
}

//文件分割成512块，每块取头8KB字节，最后一块取末8KB字节计算MD5；
+ (NSString *)stringWithMD5OfBigFile:(NSString *)path withSize:(long long)fileSize{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
	if (handle == nil) {
		return nil;
	}
    
    CC_MD5_CTX md5;
	CC_MD5_Init (&md5);
    
    int blockSize = fileSize/512;
    for (int i=0; i<511; i++) {
        [handle seekToFileOffset:i*blockSize];
        NSData *readData = [handle readDataOfLength:DEFAULT_READ_LENGTH];
        CC_MD5_Update (&md5, [readData bytes], [readData length]);
    }
    [handle seekToFileOffset:(fileSize-DEFAULT_READ_LENGTH)];
    NSData *readData = [handle readDataOfLength:DEFAULT_READ_LENGTH];
    CC_MD5_Update (&md5, [readData bytes], [readData length]);
    [handle closeFile];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final (digest, &md5);
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[output appendFormat:@"%02x",digest[i]];
	}
	return output;
}

- (NSString *)MD5Hash {
	
	CC_MD5_CTX md5;
	CC_MD5_Init (&md5);
	CC_MD5_Update (&md5, [self UTF8String], [self length]);
		
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final (digest, &md5);
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[output appendFormat:@"%02x",digest[i]];
	}
    return output;
}
@end

