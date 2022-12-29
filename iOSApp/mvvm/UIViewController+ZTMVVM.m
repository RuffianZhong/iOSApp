//
//  UIViewController+ZTMVVM.m
//  iOSApp
//  ZTMVVM UIViewController 分类
//  Created by 钟达烽 on 2022/11/9.
//

#import "UIViewController+ZTMVVM.h"
#import "kvo/ZTKVO.h"

@implementation UIViewController (ZTMVVM)

#pragma mark - 使用全局变量

static NSKeyValueObservingOptions normalOptions = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;

static NSMutableDictionary *controllerResDic;


#pragma mark - 方法交换，监听并自定义实现
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /// 方法交换逻辑
        swizzleMethodForController([self class], @selector(viewDidDisappear:), @selector(swizzled_viewDidDisappear:));
        
        /// 初始化属性逻辑
        controllerResDic = [[NSMutableDictionary alloc]init];
    });
}


void swizzleMethodForController(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod([UIViewController class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)swizzled_viewDidDisappear:(BOOL)animated
{
    // call original implementation
    [self swizzled_viewDidDisappear:animated];
    
    // Logic
    if(self.isMovingFromParentViewController){
        [self releaseResources];
    }
    
}

#pragma mark - KVO监听属性变化逻辑

#pragma mark - keyPaths 属性

- (void)observe:(id)observable notify:(void (^)(id observable,NSString *keyPath)) notify{
    
    [[self makeZTKVO] observe:observable options:normalOptions notify:notify];
}

- (void)observe:(id)observable keyPaths:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[self makeZTKVO] observe:observable keyPaths:keyPathArray options:normalOptions notify:notify];
}

- (void)observe:(id)observable keyPathsNot:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[self makeZTKVO] observe:observable keyPathsNot:keyPathArray options:normalOptions notify:notify];
}

#pragma mark - options 属性

- (void)observe:(id)observable options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[self makeZTKVO] observe:observable options:options notify:notify];
}

#pragma mark - keyPaths 属性 && options 属性

- (void)observe:(id)observable keyPaths:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[self makeZTKVO] observe:observable keyPaths:keyPathArray options:options notify:notify];
}

- (void)observe:(id)observable keyPathsNot:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify{

    [[self makeZTKVO] observe:observable keyPathsNot:keyPathArray options:normalOptions notify:notify];
}


/// 创建KVO
- (ZTKVO*)makeZTKVO{
    
    /// 创建KVO
    ZTKVO *ztKVO = [[ZTKVO alloc]init];
    
    /// 管理KVO
    NSString *key = [NSString stringWithFormat:@"%p",self];//self 地址值作为key
   
    NSMutableArray *array = nil;
    if([[controllerResDic allKeys] containsObject:key]){
        array = controllerResDic[key];
    }
    if(!array){
        array = [[NSMutableArray alloc]init];
    }
    [array addObject:ztKVO];
    [controllerResDic setObject:array forKey:key];
    
    return ztKVO;
}

/// 释放资源
- (void)releaseResources{
    NSString *key = [NSString stringWithFormat:@"%p",self];//self 地址值作为key
    
    if([[controllerResDic allKeys] containsObject:key]){
        NSMutableArray *array = controllerResDic[key];
        for(int i = 0; i < array.count; i++){
            ZTKVO *ztKVO = array[i];
            [ztKVO releaseObserver];
        }
        /// 从字典中移除对象
        [controllerResDic removeObjectForKey:key];
    }
}

@end