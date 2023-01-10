//
//  ZTUITabChildView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import "ZTUITabChildView.h"

@interface ZTUITabChildView()

@property(nonatomic,assign) CGFloat padding;//内边距
@property(nonatomic,assign) CGFloat indicatorHeight;//指示器高度
@end

@implementation ZTUITabChildView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 6;
        _indicatorHeight = 2;
        //自定义子控件初始化逻辑
        [self initViews];
    }
    return self;
}

- (void)initViews{
    _button = [[UIButton alloc] init];
    [_button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_button];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(_padding);
        make.right.mas_equalTo(self.mas_right).offset(-_padding);
    }];

    _indicator = [[UIView alloc] init];
    _indicator.backgroundColor = [UIColor whiteColor];
    _indicator.hidden = YES;
    [self addSubview:_indicator];
    
    [_indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_indicatorHeight);
        make.width.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [_button setTitle:title forState:UIControlStateNormal];
}

- (void)setSelect:(BOOL)select{
    _select = select;
    _indicator.hidden = !select;
}

//获取控件宽度
- (CGFloat)viewWidth{
    
    CGFloat width = _padding * 2 + 0.5f;//额外加 0.5f + 边距
    
    //文本size
    CGSize labelSize = [_button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_button.titleLabel.font}];
    
    width += labelSize.width;
    
    return width;
}

#pragma mark - 私有辅助方法

- (void)onButtonClick:(UIButton*)button{
    if([_delegate respondsToSelector:@selector(tabChildViewDidClick:)]){
        [_delegate tabChildViewDidClick:self];
    }
}


@end
