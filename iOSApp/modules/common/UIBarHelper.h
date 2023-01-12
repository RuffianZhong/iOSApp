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

#pragma mark - NavigationBar

+ (UINavigationController*)navigationController:(UIViewController*)controller;


/// 设置导航栏透明度
/// @param alpha 透明度
/// @param controller controller
+ (void)navigationBarAlpha:(CGFloat)alpha controller:(UIViewController*)controller;

/// 隐藏导航栏
/// @param hidden 是否隐藏
/// @param controller controller
+ (void)navigationBarHidden:(BOOL)hidden controller:(UIViewController*)controller;

/// 设置导航栏背景色
/// @param color 颜色值
/// @param controller controller
+ (void)navigationBarBackgroundColor:(UIColor*)color controller:(UIViewController*)controller;

/// 设置导航栏标题样式
/// @param color 标题颜色
/// @param font 标题字体
/// @param controller controller
+ (void)navigationBarTitleColor:(UIColor*)color font:(UIFont *)font controller:(UIViewController*)controller;

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
