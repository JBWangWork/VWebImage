//
//  VWebImageDownloadOperation.h
//  VWebImage
//
//  Created by wang on 2020/1/3.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^VDownCompleteHandle)(NSData *imageData, NSString *v_urlString);

@interface VWebImageDownloadOperation : NSOperation

@property (nonatomic, assign) NSInteger v_maxConcurrentOperationCount;

- (instancetype)initWithDownloadImageUrl:(NSString *)imageUrlString completeHandle:(VDownCompleteHandle)completeHandle title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
