//
//  NSString+VAdd.m
//  VWebImage
//
//  Created by wang on 2020/1/2.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import "NSString+VAdd.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (VAdd)
/**
 下载图片的路径

 @return MD5加密的图片下载地址
 */
- (NSString *)getDowloadImagePath{
    
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LGDiskPath"];
    NSString *md5Str = [self kc_md5String];
    NSFileManager *fileManager = NSFileManager.defaultManager;
    if (![fileManager fileExistsAtPath:cachePath]) {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [cachePath stringByAppendingPathComponent:md5Str];
}

/**
 SHA1 加密

 @return 返回SHA1加密数据
 */
- (NSString *)kc_md5String{
    
    const char *cStr = self.UTF8String;
    if (cStr == NULL) {
        cStr = "";
    }
    unsigned char r[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), r);
    
    NSURL *keyURL = [NSURL URLWithString:self];
    NSString *ext = keyURL ? keyURL.pathExtension : self.pathExtension;
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7],
            r[8], r[9], r[10],r[11], r[12], r[13], r[14], r[15], r[16], r[17], r[18], r[19],
            ext.length == 0 ? @"" : [NSString stringWithFormat:@".%@", ext]];

}
@end
