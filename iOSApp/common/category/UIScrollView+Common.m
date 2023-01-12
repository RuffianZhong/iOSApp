//
//  UIScrollView+Common.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/12.
//

#import "UIScrollView+Common.h"
#import "UIViewHelper.h"

@implementation UIScrollView (Common)

/// UIScrollerView 及其子类避免偏移 StatusBar 高度
- (void)setContentInsetAdjustmentBehaviorNO {
    /// 设置内容适配行为：UIScrollerView 及其子类避免偏移 StatusBar 高度
    /// iOS11以上通过 UIScrollerView 设置，低于目标版本通过 ViewController 设置
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        [UIViewHelper viewControllerForUIView:self].automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
