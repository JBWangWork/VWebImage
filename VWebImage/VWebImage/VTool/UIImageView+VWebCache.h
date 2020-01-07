//
//  UIImageView+VWebCache.h
//  VWebImage
//
//  Created by wang on 2020/1/3.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (VWebCache)
/**
 给imageView设置图片 Debug

 @param urlString 图片地址
 */
- (void)v_setImageWithUrlString:(NSString *)urlString title:(NSString *)title;
/**
给imageView设置图片

@param urlString 图片地址
*/
- (void)v_setImageWithUrlString:(NSString *)urlString;

// 通过关联属性创建记录对象
@property (nonatomic, copy) NSString *v_urlString;

// 记录开发
@property (nonatomic, copy) NSString *v_title;
@end

NS_ASSUME_NONNULL_END
