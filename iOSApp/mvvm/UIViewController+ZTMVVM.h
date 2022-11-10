//
//  UIViewController+ZTMVVM.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ZTMVVM)

#pragma mark - keyPaths 属性

- (void)observe:(id)observable notify:(void (^)(id observable,NSString *keyPath)) notify;

- (void)observe:(id)observable keyPaths:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify;

- (void)observe:(id)observable keyPathsNot:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify;

#pragma mark - options 属性

- (void)observe:(id)observable options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;

#pragma mark - keyPaths 属性 && options 属性

- (void)observe:(id)observable keyPaths:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;

- (void)observe:(id)observable keyPathsNot:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;

@end

NS_ASSUME_NONNULL_END
