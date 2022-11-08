//
//  DemoView.m
//  iOSApp
//  MVVM 在 View 中使用
//  Created by 钟达烽 on 2022/11/8.
//

#import "DemoView.h"
#import "ZTMVVM.h"

@implementation DemoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //自定义子控件初始化逻辑
        [self initViews];
        [self initDataNotify];
        [self initViewModel];
    }
    return self;
}


- (void)initViewModel{
    _viewModel = [[DemoViewModel alloc]init];
    [_viewModel showUserInfo];
}

- (void)initViews{
    
    _label = [[UILabel alloc]init];
    _label.backgroundColor = [UIColor redColor];
    [_label setText:@"--"];

    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top);
    }];
    
    _btn = [[UIButton alloc]init];
    _btn.backgroundColor = [UIColor grayColor];
    [_btn addTarget:self action:@selector(updateViewModel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
        make.left.mas_equalTo(_label.mas_left);
        make.top.mas_equalTo(_label.mas_bottom).offset(100);
    }];
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    NSLog(@"--willMoveToSuperview:---%@:",newSuperview);
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
    [ZTMVVM observe:_viewModel on:self notify:^(DemoViewModel *observable, NSString *keyPath) {
        self->_label.text = observable.userData.name;//更新UI
    }];
}


@end
