//
//  LifecycleViewController.m
//  mvvm
//
//  Created by 钟达烽 on 2022/11/4.
//

#import "LifecycleViewController.h"

@interface LifecycleViewController ()

@end

@implementation LifecycleViewController

- (instancetype)init{
    self = [super init];
    if (!self) return nil;
    /// 透明度为0不会渲染
    self.view.alpha = 0.0;

    return self;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if(_lifecycleDelegate){
        [_lifecycleDelegate viewDidDisappear:animated];
    }
}


@end
