//
//  ZTKVO.m
//  mvvm
//
//  备注：
//      KVO 属性更新 实现 MVVM
//
//      触发 KVO 属性更新的方式：
//      self.dataState = 0
//      [[self mutableArrayValueForKey:@"dataArray"] addObjectsFromArray:response];
//
//      不会触发 KVO 属性更新的方式：
//      _refreshState = 0; 不会触发 MVVM 属性更新
//
//  Created by 钟达烽 on 2022/11/2.
//

#import "ZTKVO.h"
#import <objc/message.h>

@implementation ZTKVO

//- (void)withController:(UIViewController *)controller{
//
//    _lifecycleViewController = [[LifecycleViewController alloc]init];
//    /// 初始化生命周期感知对象
//    [self initLifecycleViewController:controller];
//
//}

//- (void)withView:(UIView *)view{
//
//    _lifecycleView = [[LifecycleView alloc]init];
//    /// 初始化生命周期感知对象
//    [self initLifecycleView:view];
//}

#pragma mark - 核心API

///监听属性值变化（所有）
- (void)observe:(id)observable
        options:(NSKeyValueObservingOptions)options
         notify:(void (^)(id observable,NSString *keyPath)) notify{
    
   ///默认属性列表
    NSMutableArray* array=[[self _propertyNameArray:[observable class]]mutableCopy];
    
    [self observe:observable keyPaths:array options:options notify:notify];
}

///监听属性值变化（仅设置部分）
- (void)observe:(id)observable
    keyPaths:(NSArray*)keyPathArray
        options:(NSKeyValueObservingOptions)options
         notify:(void (^)(id observable,NSString *keyPath)) notify{
   
    ///缓存赋值
    _observerCache = self;
    _observableCache = observable;
    _optionsCache = options;
    _keyPathArrayCache = keyPathArray;
    _observerNotify = notify;

    ///调用核心实现
    [self addObserver:_observerCache forKeyPaths:_keyPathArrayCache options:_optionsCache context:NULL onObservable:_observableCache];
   
}

///监听属性变化（不包含设置部分）
- (void)observe:(id)observable
    keyPathsNot:(NSArray*)keyPathArray
    options:(NSKeyValueObservingOptions)options
         notify:(void (^)(id observable,NSString *keyPath)) notify{
    
    ///默认属性列表
    NSMutableArray* array=[[self _propertyNameArray:[observable class]]mutableCopy];
    
    ///过滤属性逻辑
    if(keyPathArray != nil){
        for(int j=0; j<keyPathArray.count; j++){
            NSString *key = keyPathArray[j];
            BOOL contais = [array containsObject:key];
            if(contais){
                [array removeObject:key];///移除不需要监听的属性
            }
        }
    }
    
    [self observe:observable keyPaths:array options:options notify:notify];
}

/// 释放资源
- (void)releaseObserver{
    /// 移除属性监听
    [self removeObserver:_observerCache forKeyPaths:_keyPathArrayCache onObservable:_observableCache];
    /// 释放资源
    _observerCache = nil;
    _observableCache = nil;
    _keyPathArrayCache = nil;
    _observerNotify = nil;
}

#pragma mark - 核心实现方式

/// 观察者响应属性变化
/// @param keyPath 被观察者变化的属性
/// @param object 被观察者
/// @param change 字典类型，通过键值对显示新/旧值
/// @param context 设置监听时携带的信息
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    id newValue = change[@"new"];
    id oldValue = change[@"old"];
    if(newValue != oldValue){
        //block
        _observerNotify(object,keyPath);
    }
}

/// 注册属性监听
/// @param observer 接收监听的对象
/// @param keyPathArray 属性列表
/// @param options 监听设置类型
/// @param context context description
- (void)addObserver:(NSObject *)observer
    forKeyPaths:(NSArray*)keyPathArray
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
           onObservable:(NSObject*)observable{
    if(keyPathArray!=nil){
        for (int i=0; i<keyPathArray.count; i++) {
            ///遍历添加所有的属性
             [observable addObserver:observer forKeyPath:keyPathArray[i] options:options context:context];
        }
    }
}

/// 移除KVO监听
/// @param observer observer 接收监听的对象
/// @param keyPathArray keyPathArray 属性列表
- (void)removeObserver:(NSObject *)observer forKeyPaths:(NSArray*)keyPathArray  onObservable:(NSObject*)observable{
    if(keyPathArray!=nil){
        for (int i=0; i<keyPathArray.count; i++) {
            [observable removeObserver:observer forKeyPath:keyPathArray[i]];
        }
    }
}

#pragma mark - 辅助方法

///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *) _propertyNameArray:(Class)objectClass{
    ///存储所有的属性名称
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
     
    ///存储属性的个数
    unsigned int propertyCount = 0;
     
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList(objectClass, &propertyCount);
     
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        ///属性名称
        const char * propertyName = property_getName(property);
        
        ///属性类型
        Class propertyClass = [NSObject class];
        const char* attributes = property_getAttributes(property);
        if (attributes[1] == '@') {
            NSMutableString* className = [NSMutableString new];
            for (int j=3; attributes[j] && attributes[j]!='"'; j++)
                [className appendFormat:@"%c", attributes[j]];
            propertyClass = NSClassFromString(className);
        }
        ///自定义类进一步添加子属性：parentName 点 childName
        if([self isCustomClass:propertyClass]){
            NSArray *childArray = [self _propertyNameArray:propertyClass];
            for (int i = 0; i < childArray.count; i++) {
                [nameArray addObject:[NSString stringWithFormat:@"%s.%@", propertyName,childArray[i]]];
            }
        }
         
        [nameArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
     
    ///释放
    free(propertys);
     
    return nameArray;
}

/// 是否为自定义的类
/// @param clazz 目标类型
- (BOOL)isCustomClass:(Class)clazz{
    if([NSBundle bundleForClass:clazz] == [NSBundle mainBundle]){
        return YES;
    }
    return NO;
}

#pragma mark - 生命周期
/// Controller 的生命周期
- (void)viewDidDisappear:(BOOL)animated{

    [self releaseObserver];
//    [self releaseLifecycleViewController];
}

/// View 的生命周期
- (void)didRemoveFromWindow {

    [self releaseObserver];
//    [self releaseLifecycleView];
}

/// 初始化生命周期
//- (void)initLifecycleViewController:(UIViewController *)controller{
//
//    if(controller){
//        [controller addChildViewController:_lifecycleViewController];
//        [_lifecycleViewController didMoveToParentViewController:controller];
//        [controller.view addSubview:_lifecycleViewController.view];
//
//        _lifecycleViewController.lifecycleDelegate = self;/// 设置代理
//    }
//}

//- (void)initLifecycleView:(UIView *)view{
//
//    if(view){
//        [view addSubview:_lifecycleView];
//        _lifecycleView.lifecycleDelegate = self;/// 设置代理
//    }
//}

/// 释放生命周期
//- (void)releaseLifecycleViewController{
//
//    if(_lifecycleViewController){
//        _lifecycleViewController.lifecycleDelegate = nil;
//        [_lifecycleViewController.view removeFromSuperview];
//        [_lifecycleViewController removeFromParentViewController];
//
//        _lifecycleViewController = nil;
//    }
//}

//- (void)releaseLifecycleView{
//
//    if(_lifecycleView){
//
//        _lifecycleView.lifecycleDelegate = nil;
//        [_lifecycleView removeFromSuperview];
//
//        _lifecycleView = nil;
//    }
//}

@end
