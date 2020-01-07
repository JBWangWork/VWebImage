//
//  VModel.m
//  VWebImage
//
//  Created by wang on 2020/1/2.
//  Copyright © 2020 Vincent. All rights reserved.
//

#import "VModel.h"

@implementation VModel
- (NSString *)description{
    return [NSString stringWithFormat:@"%@ 售价 : %@",self.title,self.money];
}
@end
