//
//  UIImage+Common.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Common)

/// UIImage 着色
/// @param color 目标颜色
- (UIImage*)imageWithTint:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
