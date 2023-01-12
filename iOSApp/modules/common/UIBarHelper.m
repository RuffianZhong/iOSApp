//
//  UIBarHelper.m
//  iOSApp
//  各种XXBar帮助类
//  Created by 钟达烽 on 2023/1/12.
//

#import "UIBarHelper.h"

@implementation UIBarHelper

#pragma mark -StatusBar

/// 设置状态栏颜色
/// @param color 颜色值
+ (void)statusBarBackgroundColor:(UIColor *)color {
    
    static UIView *statusBar = nil;
    static dispatch_once_t onceToken;
    if (@available(iOS 13.0, *)) {  //iOS 13不允许使用valueForKey、setValue: forKey获取和设置私有属性
        dispatch_once(&onceToken, ^{
            statusBar = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
            [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
        });
     } else {
         statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    }
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

/// 顶部状态栏高度（包括安全区）
+ (CGFloat)statusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}


#pragma mark - 安全区域高度

/// 顶部安全区高度
+ (CGFloat)safeAreaTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

/// 底部安全区高度
+ (CGFloat)safeAreaBottom {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}

#pragma mark -常用数值

/// 导航栏高度
+ (CGFloat)navigationBarHeight {
    return 44.0f;
}

/// 状态栏+导航栏的高度
+ (CGFloat)navigationBarHeightWithStatusBar {
    return [UIBarHelper statusBarHeight] + [UIBarHelper navigationBarHeight];
}

/// 底部导航栏高度
+ (CGFloat)tabBarHeight {
    return 49.0f;
}

/// 底部导航栏高度（包括安全区）
+ (CGFloat)tabBarHeightWithSafeArea {
    return [UIBarHelper tabBarHeight] + [UIBarHelper safeAreaBottom];
}


@end
