//
//  VCustomCollectionViewCell.h
//  VWebImage
//
//  Created by wang on 2020/1/2.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VCustomCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *moneyLabel;
@end

NS_ASSUME_NONNULL_END
