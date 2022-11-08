//
//  DemoController.m
//  iOSApp
//  MVVM 在 Controller 中使用
//  Created by 钟达烽 on 2022/11/8.
//

#import "DemoController.h"
#import "DemoViewModel.h"
#import "DemoView.h"
#import "ZTMVVM.h"
#import "LaunchController.h"

@interface DemoController ()

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) UIButton *btn2;
@property(nonatomic,strong) DemoView *demoView;
@property(nonatomic,strong) DemoViewModel *viewModel;

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewModel];
    [self initViews];
    [self initDataNotify];
  
    
}



- (void)updateViewModel2:(UIButton *)btn{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)initViewModel{
    _viewModel = [[DemoViewModel alloc]init];
}

- (void)initViews{
    
    _label = [[UILabel alloc]init];
    _label.backgroundColor = [UIColor redColor];
    [_label setText:@"--"];

    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
    _btn = [[UIButton alloc]init];
    _btn.backgroundColor = [UIColor grayColor];
    [_btn addTarget:self action:@selector(updateViewModel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
        make.left.mas_equalTo(_label.mas_left);
        make.top.mas_equalTo(_label.mas_bottom).offset(100);
    }];
    
    _btn2 = [[UIButton alloc]init];
    _btn2.backgroundColor = [UIColor greenColor];
    [_btn2 addTarget:self action:@selector(updateViewModel2:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btn2];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
        make.left.mas_equalTo(_btn.mas_left);
        make.top.mas_equalTo(_btn.mas_top).offset(100);
    }];
    
    
    _demoView = [[DemoView alloc]init];
    _demoView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_demoView];

    [_demoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(250);
        make.width.mas_equalTo(250);
        make.left.mas_equalTo(_btn2.mas_left);
        make.top.mas_equalTo(_btn2.mas_bottom).offset(100);
    }];

}

- (void)updateViewModel:(UIButton *)btn{
    
    /// 模拟数据更改
    
    //[500,1000)
    int random = 500 + arc4random() % (1000 - 500 + 1);
    NSString *name = [NSString stringWithFormat:@"Ruffian-%d",random];
    
    /// 驱动数据（进而更新UI）
    [_viewModel updateUserInfo:name];
    
    
    ///测试生命周期
    LaunchController *vc = [[LaunchController alloc]init];
    [[self navigationController] pushViewController:vc animated:YES];

}

- (void)initDataNotify{
    
    [ZTMVVM observe:_viewModel on:self notify:^(DemoViewModel *observable, NSString *keyPath) {
//        NSLog(@"--keyPath:%@--updateCount:%li----name:%@",keyPath,observable.updateCount,observable.userData.name);
        
//        NSString *count = [NSString stringWithFormat:@"%li",observable.updateCount ];
        
        self->_label.text = observable.userData.name;//更新UI
//        self->_label.text = count;
    }];
}


- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"-----viewDidDisappear:%@-----------",self.view);
}

- (void)viewDidUnload{
    NSLog(@"-----viewDidUnload:%@-----------",self);
}

- (void)dealloc{
    NSLog(@"-----dealloc:%@-----------",self);
}


@end
