//
//  BaseNavigationBarView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/13.
//

#import "BaseNavigationBarView.h"

@interface BaseNavigationBarView()

@property(nonatomic) CGFloat navigationBarHeight;

@property(nonatomic,strong) UIView *titleView;//内容标题View
@property(nonatomic,strong) UIView *leftBarView;//左侧按钮View
@property(nonatomic,strong) UIView *rightBarView;//右侧按钮View

@property(nonatomic,strong) UILabel *titleViewLabel;
@property(nonatomic,strong) UIButton *leftBarButton;
@property(nonatomic,strong) UIButton *rightBarButton;

@end

@implementation BaseNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initViews];
    }
    return self;
}

- (void)initViews{
    _navigationBarHeight = self.frame.size.height;
//    self.frame = CGRectMake(0, [UIBarHelper statusBarHeight], kScreenWidth, _navigationBarHeight);
    [self setCustomLeftBarView:self.leftBarButton];
    [self setCustomRightBarView:self.rightBarButton];
    [self setCustomTitleView:self.titleViewLabel];
}

- (UIView *)leftBarView{
    if(!_leftBarView){
        _leftBarView = [[UIView alloc] init];
        [self addSubview:_leftBarView];
    }
    return _leftBarView;
}

- (UIView *)rightBarView{
    if(!_rightBarView){
        _rightBarView = [[UIView alloc] init];
        [self addSubview:_rightBarView];
    }
    return _rightBarView;
}

- (UIView *)titleView{
    if(!_titleView){
        _titleView = [[UIView alloc] init];
        [self addSubview:_titleView];
    }
    return _titleView;
}

- (UILabel*)titleViewLabel{
    if(!_titleViewLabel){
        CGFloat width = self.frame.size.width - _navigationBarHeight*2 - 4*2;
        _titleViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, _navigationBarHeight)];
        _titleViewLabel.font = kFontText18;
        _titleViewLabel.textColor= [UIColor whiteColor];
        _titleViewLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleViewLabel;
}

- (UIButton*)leftBarButton{
    if(!_leftBarButton){
        _leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _navigationBarHeight, _navigationBarHeight)];
        [_leftBarButton setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
        [_leftBarButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBarButton;
}

- (UIButton*)rightBarButton{
    if(!_rightBarButton){
        _rightBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _navigationBarHeight, _navigationBarHeight)];
//        [_rightBarButton setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
        [_rightBarButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBarButton;
}

- (void)buttonClickEvent:(UIButton*)button{
    if(button == self.leftBarButton){
        if(_leftBarHandler) _leftBarHandler(0);
    }else if (button == self.rightBarButton){
        if(_rightBarHandler) _rightBarHandler(0);
    }
}

#pragma mark - 对外函数

- (void)setCustomLeftBarView:(UIView*)leftBarView{
    //移除旧数据
    [[self.leftBarView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //添加新数据
    [self.leftBarView addSubview:leftBarView];

    [self.leftBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(4);
        make.width.mas_equalTo(leftBarView.frame.size.width);
    }];

}

- (void)setCustomRightBarView:(UIView*)rightBarView{
    //移除旧数据
    [[self.rightBarView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //添加新数据
    [self.rightBarView addSubview:rightBarView];
    [self.rightBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-4);
        make.width.mas_equalTo(rightBarView.frame.size.width);
    }];

}

- (void)setCustomTitleView:(UIView*)titleView{
    //移除旧数据
    [[self.titleView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //添加新数据
    [self.titleView addSubview:titleView];
    [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.leftBarView.mas_right).offset(4);
        make.right.mas_equalTo(self.rightBarView.mas_left).offset(-4);
    }];
    [titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.titleView);
        if(titleView == self.titleViewLabel){
            make.width.height.mas_equalTo(self.titleView);
        }else{
            make.size.mas_equalTo(titleView.frame.size);
        }
    }];
}

- (void)setTitleText:(NSString*)title{
    self.titleViewLabel.text = title;
}

-(void)setLeftImage:(UIImage*)leftImage{
    [self.leftBarButton setImage:leftImage forState:UIControlStateNormal];
}

-(void)setRightImage:(UIImage*)rightImage{
    [self.rightBarButton setImage:rightImage forState:UIControlStateNormal];
}

- (CGFloat)height{
    return _navigationBarHeight;
}
@end
