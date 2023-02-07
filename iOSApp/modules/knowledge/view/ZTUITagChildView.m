//
//  ZTUITagChildView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/17.
//

#import "ZTUITagChildView.h"
@interface ZTUITagChildView()
@property(nonatomic,assign) NSInteger padding;
@end

@implementation ZTUITagChildView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 6;
        _editImage = [UIImage imageNamed:@"ic_tab_home"];
        //自定义子控件初始化逻辑
        [self initViews];
    }
    return self;
}

- (void)initViews{
    //编辑按钮
    _editButton = [[UIButton alloc] init];
    [_editButton setImage:_editImage forState:UIControlStateNormal];
    [_editButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editButton];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(0);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right);
    }];
    
    //文本按钮
    _button = [[UIButton alloc] init];
    [_button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [_button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(_editButton.mas_left);
    }];
    //标签控件
    self.backgroundColor = UIColorFromRGB(0xFF9E9E9E);
    [self zt_cornerWithCornerRadii:100];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [_button setTitle:title forState:UIControlStateNormal];
}

- (void)setEditing:(BOOL)editing{
    _editing = editing;
    [_editButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = _editing? _editImage.size.height + _padding * 2 : 0;
        CGFloat width = _editing? _editImage.size.width + _padding * 2 : 0;
        
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right);
    }];
}

//获取控件Size
- (CGSize)sizeForView:(UIButton *)button{
    CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
    return size;
}

- (CGFloat)viewHeight{
    CGFloat diff = 1.0f;//误差

    CGFloat buttonHeight = [self sizeForView:_button].height + _padding * 2;//文本高度+上下适当边距
    
    return buttonHeight + diff;
}

- (CGFloat)viewWidth{
    CGFloat diff = 1.0f;//误差
    
    CGFloat editViewWidth = 0;
    if(_editing){
        editViewWidth = _editImage.size.width + _padding * 2;
    }
    
    CGFloat buttonWidth = [self sizeForView:_button].width + _padding * 2;//文本宽度+左右适当边距
    
    return buttonWidth + editViewWidth + diff;
}


#pragma mark - 私有辅助方法

- (void)onButtonClick:(UIButton*)button{
    if(button == _editButton){
        if([_delegate respondsToSelector:@selector(tagChildViewDidEdit:)]){
            [_delegate tagChildViewDidEdit:self];
        }
    }else if(button == _button){
        if([_delegate respondsToSelector:@selector(tagChildViewDidClick:)]){
            [_delegate tagChildViewDidClick:self];
        }
    }
}
@end
