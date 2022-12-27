//
//  AppDelegate.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import "AppDelegate.h"

#import "demo/mvvm/DemoController.h"

#import "demo/ui_style/DemoGradientController.h"
#import "demo/ui_style/DemoBorderController.h"
#import "demo/ui_style/DemoCornerController.h"
#import "demo/ui_style/DemoShadowController.h"
#import "demo/ui_style/DemoMixedController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.创建根控制器
//    DemoController *launchController = [[DemoController alloc]init];
    
//    DemoBorderController *launchController = [[DemoBorderController alloc]init];
//      DemoGradientController *launchController = [[DemoGradientController alloc]init];
//    DemoCornerController *launchController = [[DemoCornerController alloc]init];
//    DemoShadowController *launchController = [[DemoShadowController alloc]init];
    DemoMixedController *launchController = [[DemoMixedController alloc]init];

    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:launchController];
//    navController.navigationBarHidden = YES;
    navController.navigationBar.translucent = NO;
    navController.navigationBar.barTintColor = [UIColor orangeColor];
        
    //3.显示窗口
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    _navController = navController;
    
    return YES;
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}


@end
