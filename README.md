# iOSApp
这是一个使用 MVVM 模式架构的 iOSApp，目的是通过编写一个完整的 App 来探讨学习 iOS 应用开发中常用的一些架构模式，开发方法，常用控件，控件样式自定义，基本动画，自定义View...

一.MVVM 

这里的 MVVM 模式是基于 KVO 特性，实现属性更改监听，通过感知 UIViewController/UIView 生命周期实现资源管理和释放。

- [Y] 使用简单，无侵入
- [Y] 自动管理资源，无须手动释放，不存在内存泄漏
- [Y] 支持点语法
- [Y] 支持 UIView / UIViewController


1.使用简单

```objectivec

///添加 UIViewController 分类
#import "mvvm/UIViewController+ZTMVVM.h"


//某个你需要监听的数据类
_viewModel = [[DemoViewModel alloc]init]

//监听数据变化：更新UI
[self observe:_viewModel notify:^(DemoViewModel *observable, NSString *keyPath) {
    self->_label.text = observable.userData.name;//更新UI
}];

///更新数据
_viewModel.userData.name = @"Ruffian";

```

2.其他接口

```objectivec

//监听所有属性
- (void)observe:(id)observable notify:(void (^)(id observable,NSString *keyPath)) notify;

//设置 需要 监听的属性
- (void)observe:(id)observable keyPaths:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify;

//设置 不需要 监听的属性
- (void)observe:(id)observable keyPathsNot:(NSArray*)keyPathArray notify:(void (^)(id observable,NSString *keyPath)) notify;


//设置 NSKeyValueObservingOptions
- (void)observe:(id)observable options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;


//设置 NSKeyValueObservingOptions 和 需要监听的属性
- (void)observe:(id)observable keyPaths:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;

//设置 NSKeyValueObservingOptions 和 不需要监听的属性
- (void)observe:(id)observable keyPathsNot:(NSArray*)keyPathArray options:(NSKeyValueObservingOptions)options notify:(void (^)(id observable,NSString *keyPath)) notify;

```

3.我认为的使用姿势

```objectivec

-------------UIView/UIViewController-------------
"DemoController.m"

/// 监听数据变化：更新UI
[self observe:_viewModel notify:^(DemoViewModel *observable, NSString *keyPath) {
    ///更新UI
    self->_label.text = observable.userData.name;
}];

/// 通过 ViewModel 管理数据
[_viewModel showUserInfo];

/// 通过 ViewModel 更新数据
[_viewModel updateUserInfo:name];


-------------ViewModel-------------
"DemoViewModel.m"

@property(nonatomic,strong) UserData *userData;//用户数据类

@property(nonatomic,strong) UserModel *userModel;//用户相关 model

///更新数据
- (void)updateUserInfo:(NSString *)name{
    
    ///更新实体类数据
    self.userData.name = name;
}

///获取数据
- (void)showUserInfo{
    self.userData = _userModel.getUserData;
}

-------------Model-------------

"UserModel.m"

///获取用户数据信息
- (UserData *)getUserData{
    UserData *userData = [[UserData alloc]init];
    userData.name = name;
    return userData;
}


"UserData.h"

@interface UserData : NSObject
@property(nonatomic,assign) NSInteger uid;
@property(nonatomic,copy) NSString* name;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableDictionary *dictionary;
@property(nonatomic,strong) UserChild *child;
@end

```





