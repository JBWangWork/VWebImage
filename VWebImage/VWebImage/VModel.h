//
//  VModel.h
//  VWebImage
//
//  Created by wang on 2020/1/2.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VModel : NSObject
@property (nonatomic, copy) NSString  *imageUrl;
@property (nonatomic, copy) NSString  *title;
@property (nonatomic, copy) NSString  *money;
// 缓存下载的图片
@property (nonatomic, strong) UIImage *image;
@end

NS_ASSUME_NONNULL_END
