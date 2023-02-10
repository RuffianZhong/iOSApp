//
//  UIViewHelper.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/12.
//

#import "UIViewHelper.h"

@implementation UIViewHelper

#pragma mark -UIScrollerView

/// 获取 UIView 所在的 UIViewController
/// @param view 某个View
+ (UIViewController *)viewControllerForUIView:(UIView*)view {
    UIResponder *next = [view nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

@end
