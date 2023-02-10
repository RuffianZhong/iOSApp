//
//  AppDelegate.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import "AppDelegate.h"
#import "LaunchController.h"
#import "MainController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.创建根控制器
    LaunchController *launchController = [[LaunchController alloc]init];
    [self.rootController pushViewController:launchController animated:NO];
        
    //3.显示窗口
    self.window.rootViewController = self.rootController;
    [self.window makeKeyAndVisible];
        
    return YES;
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (BaseUINavigationController *)rootController{
    if(!_rootController){
        _rootController = [[BaseUINavigationController alloc] init];
        _rootController.navigationBarHidden = YES;
    }
    return _rootController;
}

#pragma mark -语言

- (NSString *)language{
    if (!_language) {
        _language = [NSUserDefaultsUtils objectForKey:languageKey];
        if(!_language){
            _language = Language_zh;
        }
    }
    return _language;
}


/// 设置应用语言
/// 1.更改 NSBundle
/// 2.更改本地存储
/// 3.重新赋值根控制器 / 响应通知重新赋值
/// @param language 语言
- (void)setAppLanguage:(NSString *)language{
    _language = language;
    
    [NSUserDefaultsUtils setObject:language forKey:languageKey];
    
    [self restartRootController];
}

/// 重新设置根控制器
- (void)restartRootController{
    //通用逻辑：移除所有控制器，再添加新的根控制器
    //本项目中根控制不变，只移除根控制器下所有老旧子控制器，再添加新的目标页面（此处为主业，也可能是登录页面等等，看具体需求）
    [self startToMainPage];
}


- (void)startToMainPage{
    //清除根控制器中所有子控制器
    BaseUINavigationController *rootController = self.rootController;
    NSArray<UIViewController*> *controllerArray = [rootController childViewControllers];
    for (int i = 0; i < controllerArray.count; i++) {
        [controllerArray[i] removeFromParentViewController];
    }
    
    //在根控制器中添加新的主页控制器
    MainController *mainController = [[MainController alloc] init];//主页
    [rootController pushViewController:mainController animated:NO];
}

@end
