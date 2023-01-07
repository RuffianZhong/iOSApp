//
//  UITabChildView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/7.
//

#import "UITabChildView.h"

@implementation UITabChildView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //自定义子控件初始化逻辑
        [self initViews];
    }
    return self;
}

- (void)initViews{
    _button = [[UIButton alloc] init];
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self);
        make.left.top.mas_equalTo(self);
    }];
    
    _indicator = [[UIView alloc] init];
    _indicator.backgroundColor = [UIColor purpleColor];
    [self addSubview:_indicator];
    [_indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(5);
        make.width.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
}

- (void)setSelect:(BOOL)select{
    _select = select;
    [self updateUI:select];
}

- (void)updateUI:(BOOL)select{
    _indicator.hidden = !select;
}


@end
