//
//  UIImageView+VWebCache.m
//  VWebImage
//
//  Created by wang on 2020/1/3.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import "UIImageView+VWebCache.h"
#import "VWebImageManager.h"
#import <objc/runtime.h>

const char *vAssociatedKey_imageUrlString = "vAssociatedKey_imageUrlString";
const char *vAssociatedKey_title = "vAssociatedKey_title";

@implementation UIImageView (VWebCache)
- (void)v_setImageWithUrlString:(NSString *)urlString title:(NSString *)title {
    if (!urlString) {
        VLog(@"下载地址为空");
        return;
    }
    
    if ([self.v_urlString isEqualToString:urlString]) {
        VLog(@"%@ 两次下载地址一样的 没必要重复下载",title);
        return;
    }
    
    if (self.v_urlString && self.v_urlString.length > 0 && ![self.v_urlString isEqualToString:urlString]) {
        VLog(@"取消之前的下载操作:%@---%@ \n%@---%@",self.v_title,title,self.v_urlString,urlString);
        [[VWebImageManager sharedManager] cancelDownloadImageWithUrlString:self.v_urlString];
    }
    //记录新操作开始下载
    self.v_urlString = urlString;
    self.v_title = title;
    // 复用
    self.image = nil;
    
    [[VWebImageManager sharedManager] downloadImageWithUrlString:urlString completeHandle:^(UIImage *downloadImage,NSString *urlString) {
        //下载完成 要置空
        if ([urlString isEqualToString:self.v_urlString]) {
            self.v_urlString = @"";
            self.v_title = @"";
            self.image = downloadImage;
        }
    } title:title];
}

- (void)v_setImageWithUrlString:(NSString *)urlString {
    [self v_setImageWithUrlString:urlString title:@""];
}

- (void)setV_urlString:(NSString *)v_urlString {
    /**
     1: 绑定的对象
     2: 关联键,通过这个键去找
     3: 值
     4: 关联策略
     */
    objc_setAssociatedObject(self, vAssociatedKey_imageUrlString, v_urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)v_urlString {
    return objc_getAssociatedObject(self, vAssociatedKey_imageUrlString);
}

- (void)setV_title:(NSString *)v_title {
    objc_setAssociatedObject(self, vAssociatedKey_title, v_title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)v_title {
    return objc_getAssociatedObject(self, vAssociatedKey_title);
}
@end
