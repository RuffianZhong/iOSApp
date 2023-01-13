//
//  UIBarHelper.m
//  iOSApp
//  各种XXBar帮助类
//  https://www.jianshu.com/p/b2585c37e14b
//  https://blog.csdn.net/weixin_42292229/article/details/124054651
//  https://www.jianshu.com/p/454b06590cf1
//  https://www.jianshu.com/p/e3ca1b7b6cec
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

#pragma mark - NavigationBar

+ (UINavigationController*)navigationController:(UIViewController*)controller{
    UINavigationController *navigationController;
    if( [controller isKindOfClass:[UINavigationController class]] ){
        navigationController = (UINavigationController*)controller;
    }else{
        navigationController = controller.navigationController;
    }
    return navigationController;
}

/// 设置导航栏透明度
/// @param alpha 透明度
/// @param controller controller
+ (void)navigationBarAlpha:(CGFloat)alpha controller:(UIViewController*)controller{
    UINavigationController *navigationController = [UIBarHelper navigationController:controller];
    [[[navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
}

/// 隐藏导航栏
/// @param hidden 是否隐藏
/// @param controller controller
+ (void)navigationBarHidden:(BOOL)hidden controller:(UIViewController*)controller{
    UINavigationController *navigationController = [UIBarHelper navigationController:controller];

    navigationController.navigationBar.hidden = hidden;
}

/// 设置导航栏背景色
/// @param color 颜色值
/// @param controller controller
+ (void)navigationBarBackgroundColor:(UIColor*)color controller:(UIViewController*)controller{
    UINavigationController *navigationController = [UIBarHelper navigationController:controller];

    ///导航栏背景颜色
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [[UINavigationBarAppearance alloc] init];
        appperance.backgroundColor = color;

        navigationController.navigationBar.standardAppearance = appperance;
        navigationController.navigationBar.scrollEdgeAppearance = appperance;
    }else{
        navigationController.navigationBar.translucent = NO;
        navigationController.navigationBar.barTintColor = color;//背景颜色，导航条背景色
    }
}

/// 设置导航栏标题样式
/// @param color 标题颜色
/// @param font 标题字体
/// @param controller controller
+ (void)navigationBarTitleColor:(UIColor*)color font:(UIFont *)font controller:(UIViewController*)controller{
    UINavigationController *navigationController = [UIBarHelper navigationController:controller];

    //设置字体颜色&大小
    NSDictionary<NSAttributedStringKey, id> *titleTextAttributes = @{
        NSForegroundColorAttributeName:color,
        NSFontAttributeName:font
    };
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [[UINavigationBarAppearance alloc] init];
        appperance.titleTextAttributes = titleTextAttributes;

        navigationController.navigationBar.standardAppearance = appperance;
        navigationController.navigationBar.scrollEdgeAppearance = appperance;
    }else{
        navigationController.navigationBar.titleTextAttributes = titleTextAttributes;
    }
}

#pragma mark - UITabBar

/// 设置 UITabBar 背景色
/// @param tabBar UITabBar
/// @param color 颜色
+ (void)tabBarBackgroundColor:(UITabBar*)tabBar color:(UIColor*)color{
    UIImage *image = [UIImage imageWithSize:tabBar.frame.size color:color cornerRadius:0.f];
    [UIBarHelper tabBarBackgroundImage:tabBar image:image];
}

/// 设置 UITabBar 背景图片
/// @param tabBar UITabBar
/// @param image 图片
+ (void)tabBarBackgroundImage:(UITabBar*)tabBar image:(UIImage*)image{
    tabBar.backgroundImage = image;
    tabBar.translucent = NO;
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
