//
//  VWebImageManager.h
//  VWebImage
//
//  Created by wang on 2020/1/3.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VCompleteHandle)(UIImage *downloadImage,NSString *urlString);

@interface VWebImageManager : NSObject
/**
 单利方法
 @return 返回全局单利实例
 */
+ (instancetype)sharedManager;

/**
 图片下载方法

 @param urlString 图片下载地址
 @param completeHandle 下载后的回调
 */
- (void)downloadImageWithUrlString:(NSString *)urlString completeHandle:(VCompleteHandle)completeHandle title:(NSString *)title;


/**
 取消下载操作
 */
- (void)cancelDownloadImageWithUrlString:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
