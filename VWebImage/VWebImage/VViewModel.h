//
//  VViewModel.h
//  VWebImage
//
//  Created by wang on 2020/1/2.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(id data);

@interface VViewModel : NSObject
@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailBlock failBlock;

- (instancetype)initWithBlock:(SuccessBlock __nullable)successBlock fail:(FailBlock __nullable)failBlock;
@end

NS_ASSUME_NONNULL_END
