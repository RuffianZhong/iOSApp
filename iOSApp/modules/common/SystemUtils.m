//
//  SystemUtils.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/13.
//

#import "SystemUtils.h"

@implementation SystemUtils

/// 判断当前是否使用暗黑外观
+ (BOOL)isDarkAppearance{
    BOOL isDark = NO;
    if (@available(iOS 13.0, *)) {
        isDark = UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    return isDark;
}
@end
