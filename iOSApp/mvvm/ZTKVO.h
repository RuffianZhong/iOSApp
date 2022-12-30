//
//  ZTKVO.h
//  mvvm
//
//  Created by 钟达烽 on 2022/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTKVO<T> : NSObject

@property(nonatomic,strong) NSObject *observerCache;
@property(nonatomic,strong) id observableCache;
@property(nonatomic,strong) NSArray *keyPathArrayCache;
@property(nonatomic,assign) NSKeyValueObservingOptions optionsCache;
@property(nonatomic,copy) void (^observerNotify)(T observable,NSString *keyPath);

//@property(nonatomic,strong) LifecycleViewController *lifecycleViewController;
//@property(nonatomic,strong) LifecycleView *lifecycleView;

//- (void)withController:(UIViewController *)controller;
//- (void)withView:(UIView *)view;

///监听属性值变化（所有）
- (void)observe:(T)observable
        options:(NSKeyValueObservingOptions)options
         notify:(void (^)(T observable,NSString *keyPath)) notify;

///监听属性值变化（仅设置部分）
- (void)observe:(T)observable
    keyPaths:(NSArray*)keyPathArray
        options:(NSKeyValueObservingOptions)options
         notify:(void (^)(T observable,NSString *keyPath)) notify;

///监听属性变化（不包含设置部分）
- (void)observe:(T)observable
    keyPathsNot:(NSArray*)keyPathArray
    options:(NSKeyValueObservingOptions)options
         notify:(void (^)(T observable,NSString *keyPath)) notify;

/// 释放资源
- (void)releaseObserver;

@end

NS_ASSUME_NONNULL_END
