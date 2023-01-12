//
//  UIScrollView+Common.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Common)

/// UIScrollerView 及其子类避免偏移 StatusBar 高度
- (void)setContentInsetAdjustmentBehaviorNO;

@end

NS_ASSUME_NONNULL_END
