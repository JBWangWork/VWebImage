//
//  NSString+VAdd.h
//  VWebImage
//
//  Created by wang on 2020/1/2.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (VAdd)
/**
 下载图片的路径
 
 @return MD5加密的图片下载地址
 */
- (NSString *)getDowloadImagePath;
@end

NS_ASSUME_NONNULL_END
