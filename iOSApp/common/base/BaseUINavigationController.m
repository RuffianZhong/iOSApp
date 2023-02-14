//
//  BaseUINavigationController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/12.
//

#import "BaseUINavigationController.h"

@interface BaseUINavigationController ()

@end

@implementation BaseUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -StatusBar
//iOS7之后只有顶部VC能够修改StatusBar，需要重写此方法
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (void)dealloc{
    NSLog(@"---nav--dealloc:%@",self);
}
@end
