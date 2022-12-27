//
//  DemoBaseController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/19.
//

#import "DemoBaseController.h"

@interface DemoBaseController ()

@end

@implementation DemoBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollView];
}

- (void)initScrollView{
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.top.right.bottom.mas_equalTo(self.view);
    }];
}

- (UILabel*)makeLabel:(UIColor*)bgColor text:(NSString*)text{
    UILabel *view = [[UILabel alloc] init];
    view.backgroundColor = bgColor;
    view.text = text;
    view.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:view];
    return view;
}

@end
