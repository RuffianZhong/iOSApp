//
//  DemoController.m
//  iOSApp
//  MVVM 在 Controller 中使用
//  Created by 钟达烽 on 2022/11/8.
//

#import "DemoController.h"
#import "DemoViewModel.h"
#import "DemoView.h"

@interface DemoController ()

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) DemoView *demoView;
@property(nonatomic,strong) DemoViewModel *viewModel;

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewModel];
    [self initViews];
    [self initDataNotify];
    [_viewModel showUserInfo];
}

- (void)initViewModel{
    _viewModel = [[DemoViewModel alloc]init];
}

- (void)initViews{
    
    _label = [[UILabel alloc]init];
    _label.backgroundColor = [UIColor grayColor];
    [_label setText:@"--"];

    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
    }];
    
    _btn = [[UIButton alloc]init];
    _btn.backgroundColor = [UIColor greenColor];
    [_btn setTitle:@"更新数据" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(updateViewModel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(self.view);
        make.left.mas_equalTo(_label.mas_left);
        make.top.mas_equalTo(_label.mas_bottom);
    }];
    
    _demoView = [[DemoView alloc]init];
    [self.view addSubview:_demoView];

    [_demoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
        make.left.mas_equalTo(_btn.mas_left);
        make.top.mas_equalTo(_btn.mas_bottom).offset(100);
    }];

}

- (void)updateViewModel:(UIButton *)btn{
    
    /// 模拟数据更改
    //[500,1000)
    int random = 500 + arc4random() % (1000 - 500 + 1);
    NSString *name = [NSString stringWithFormat:@"Ruffian-%d",random];
    
    /// 驱动数据（进而更新UI）
    [_viewModel updateUserInfo:name];
    

}

- (void)initDataNotify{
    
    [self observe:_viewModel notify:^(DemoViewModel *observable, NSString *keyPath) {
        self->_label.text = observable.userData.name;//更新UI
    }];
}


@end
