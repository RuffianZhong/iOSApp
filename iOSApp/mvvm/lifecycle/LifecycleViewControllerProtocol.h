//
//  LifecycleViewControllerProtocol.h
//  mvvm
//
//  Created by 钟达烽 on 2022/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LifecycleViewControllerProtocol <NSObject>

- (void)viewDidDisappear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
