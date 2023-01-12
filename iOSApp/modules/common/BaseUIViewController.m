//
//  BaseUIViewController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/12.
//

#import "BaseUIViewController.h"

@interface BaseUIViewController ()

@end

@implementation BaseUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - StatusBar

//设置StatusBar样式
- (UIStatusBarStyle)preferredStatusBarStyle{
//    黑色
//    if (@available(iOS 13.0, *)) {
//        return UIStatusBarStyleDarkContent;
//    } else {
//        return UIStatusBarStyleDefault; //黑色, 默认值
//    }
    
//    白色
//    return UIStatusBarStyleLightContent;

    return UIStatusBarStyleDefault;//根据主题自适应
}

//显示隐藏StatusBar
- (BOOL)prefersStatusBarHidden{
    return NO;
}

@end
