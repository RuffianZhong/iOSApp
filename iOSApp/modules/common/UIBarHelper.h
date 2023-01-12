//
//  UIBarHelper.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarHelper : NSObject

#pragma mark -StatusBar

/// 设置状态栏颜色
/// @param color 颜色值
+ (void)statusBarBackgroundColor:(UIColor *)color;

/// 顶部状态栏高度（包括安全区）
+ (CGFloat)statusBarHeight;


#pragma mark - 安全区域高度

/// 顶部安全区高度
+ (CGFloat)safeAreaTop;

/// 底部安全区高度
+ (CGFloat)safeAreaBottom;

#pragma mark -常用数值

/// 导航栏高度
+ (CGFloat)navigationBarHeight;

/// 状态栏+导航栏的高度
+ (CGFloat)navigationBarHeightWithStatusBar;

/// 底部导航栏高度
+ (CGFloat)tabBarHeight;

/// 底部导航栏高度（包括安全区）
+ (CGFloat)tabBarHeightWithSafeArea;


@end

NS_ASSUME_NONNULL_END
