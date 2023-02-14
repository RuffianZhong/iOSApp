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
    //导航栏/状态栏
    [UIBarHelper statusBarBackgroundColor:kColorDarkGreen];
    [UIBarHelper navigationBarHidden:YES controller:self];
    [self setNavigationBarBackground:kColorDarkGreen];
    WeakSelf
    [self setNavigationLeftBarHandler:^(NSInteger index) {
        [weakSelf.navigationController popViewControllerAnimated:YES];//默认退出界面
    }];
    
    //背景/内容区域
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark - BaseNavigationBarView 统一提供外层方法，方便后续维护/替换

- (BaseNavigationBarView *)navigationBarView{
    if(!_navigationBarView){
        CGRect frame = CGRectMake(0, [UIBarHelper statusBarHeight], kScreenWidth, 44.0f);
        _navigationBarView = [[BaseNavigationBarView alloc] initWithFrame:frame];
        [self.view addSubview:_navigationBarView];
    }
    return _navigationBarView;
}

-(void)setNavigationBarHiden:(BOOL)hiden{
    CGRect frame = CGRectMake(0, [UIBarHelper statusBarHeight], kScreenWidth, hiden ? 0.f : 44.0f);
    self.navigationBarView.frame = frame;
}

-(void)setNavigationBarBackground:(UIColor*)color{
    self.navigationBarView.backgroundColor = color;
}

-(void)setNavigationTitle:(NSString*)title{
    [self.navigationBarView setTitleText:title];
}

-(void)setNavigationLeftImage:(UIImage*)image{
    [self.navigationBarView setLeftImage:image];
}

-(void)setNavigationRightImage:(UIImage*)image{
    [self.navigationBarView setRightImage:image];
}

-(void)setNavigationLeftBarHandler:(void(^)(NSInteger index))handler{
    [self.navigationBarView setLeftBarHandler:handler];
}

-(void)setNavigationRightBarHandler:(void(^)(NSInteger index))handler{
    [self.navigationBarView setRightBarHandler:handler];
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

//显示隐藏StatusBar：如果需要隐藏状态栏，子类重写覆盖此函数
- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)dealloc{
    NSLog(@"---vc--dealloc:%@",self);
}
@end
