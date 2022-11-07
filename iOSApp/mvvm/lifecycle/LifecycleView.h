//
//  LifecycleView.h
//  mvvm
//
//  Created by 钟达烽 on 2022/11/5.
//

#import <UIKit/UIKit.h>
#import "LifecycleViewProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface LifecycleView : UIView
/// 生命周期代理
@property(nonatomic,strong) _Nullable id<LifecycleViewProtocol> lifecycleDelegate;
@end

NS_ASSUME_NONNULL_END
