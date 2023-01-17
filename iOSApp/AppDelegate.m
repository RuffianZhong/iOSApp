//
//  AppDelegate.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import "AppDelegate.h"
#import "LaunchController.h"
#import "modules/main/controller/MainController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.创建根控制器
    
    LaunchController *launchController = [[LaunchController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:launchController];
    navController.navigationBarHidden = YES;
        
    //3.显示窗口
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    _navController = navController;
    
    return YES;
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
    UIViewController *oldRootVC = self.window.rootViewController;

    oldRootVC = nil;
    
    MainController *newRootVC = [[MainController alloc]init];

    self.window.rootViewController = newRootVC;
}


+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)startToMainPage{
    //首页控制器
    MainController *mainController = [[MainController alloc]init];
    self.window.rootViewController = mainController;
}


@end
