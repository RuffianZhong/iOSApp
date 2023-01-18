//
//  ZTUITagChildView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/17.
//

#import "ZTUITagChildView.h"
@interface ZTUITagChildView()

@property(nonatomic,assign) NSInteger padding;
@property(nonatomic,assign) NSInteger margin;

@end

@implementation ZTUITagChildView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 6;
        _margin = 6;
        //自定义子控件初始化逻辑
        [self initViews];
    }
    return self;
}

- (void)initViews{
    _button = [[UIButton alloc] init];
    _button.backgroundColor = [UIColor grayColor];
    [_button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-_margin);
        make.right.mas_equalTo(self.mas_right).offset(-_margin);
    }];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [_button setTitle:title forState:UIControlStateNormal];
    [_button zt_cornerWithCornerRadii:[self viewHeight] / 2.0f];
}


//获取控件Size
- (CGSize)sizeForView:(UIButton *)button{
    CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    return size;
}

- (CGFloat)viewHeight{
    return [self sizeForView:_button].height + _padding * 2 + _margin;
}


- (CGFloat)viewWidth{
    return [self sizeForView:_button].width + _padding * 3 + _margin;
}


#pragma mark - 私有辅助方法

- (void)onButtonClick:(UIButton*)button{
    if([_delegate respondsToSelector:@selector(tagChildViewDidClick:)]){
        [_delegate tagChildViewDidClick:self];
    }
}
@end
