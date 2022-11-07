//
//  UIViewController+MVVM.h
//  mvvm
//
//  Created by 钟达烽 on 2022/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MVVM)

#pragma mark - keyPaths 属性

- (void)observe:(id)observable on:(UIResponder*)responder notify:(void (^)(id observable,NSString *keyPath)) notify;

- (void)observe:(id)observable on:(UIResponder*)responder keyPaths:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify;

- (void)observe:(id)observable on:(UIResponder*)responder keyPathsNot:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify;

#pragma mark - options 属性

- (void)observe:(id)observable on:(UIResponder*)responder options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;

#pragma mark - keyPaths 属性 && options 属性

- (void)observe:(id)observable on:(UIResponder*)responder keyPaths:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;

- (void)observe:(id)observable on:(UIResponder*)responder keyPathsNot:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;

@end

NS_ASSUME_NONNULL_END
