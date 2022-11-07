//
//  LifecycleViewController.h
//  mvvm
//
//  Created by 钟达烽 on 2022/11/4.
//

#import <UIKit/UIKit.h>
#import "LifecycleViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LifecycleViewController : UIViewController

/// 生命周期代理
@property(nonatomic,strong) _Nullable id<LifecycleViewControllerProtocol> lifecycleDelegate;

@end

NS_ASSUME_NONNULL_END
