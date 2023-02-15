//
//  LaunchController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import "LaunchController.h"

@interface LaunchController ()
@property(nonatomic,strong) UIImageView *ivLogo;
@end

@implementation LaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorDarkGreen;
    [self initViews];
}

- (void)initViews{
    _ivLogo = [[UIImageView alloc] init];
    [_ivLogo setImage: [UIImage imageNamed:@"ic_logo"]];
    [self.view addSubview:_ivLogo];
    [_ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [UIView animateKeyframesWithDuration:1.0 delay:0.1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.view.alpha = 0.1;
        } completion:^(BOOL finished) {
            //跳转登录页面
            [[AppDelegate shareAppDelegate] startToMainPage];
        }];
}

@end
