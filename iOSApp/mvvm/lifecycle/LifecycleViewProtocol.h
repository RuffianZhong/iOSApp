//
//  LifecycleViewProtocol.h
//  mvvm
//
//  Created by 钟达烽 on 2022/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LifecycleViewProtocol <NSObject>

/// 从 window 中移除
- (void)didRemoveFromWindow;

@end

NS_ASSUME_NONNULL_END
