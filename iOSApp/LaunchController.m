//
//  LaunchController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import "LaunchController.h"

@interface LaunchController ()

@end

@implementation LaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [UIView animateKeyframesWithDuration:1.0 delay:1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.view.alpha=0.1;
        } completion:^(BOOL finished) {
            //跳转登录页面
            [[AppDelegate shareAppDelegate] startToMainPage];
        }];
}

@end
