//
//  SearchKeywordView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import "SearchKeywordView.h"
@interface SearchKeywordView()<ZTUITagViewDelegate>
@property(nonatomic,assign) BOOL editing;
@end

@implementation SearchKeywordView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _editing = NO;
        [self initHotKeywordView];
        [self initHistoryKeywordView];
    }
    return self;
}


- (void)initHotKeywordView{
    //热搜标题
    _hotTitleLabel = [[UILabel alloc] init];
    _hotTitleLabel.font = kFontText16;
    _hotTitleLabel.text= L(@"search_hot_title");
    _hotTitleLabel.textColor = kColorDarkGreen;
    [self addSubview:_hotTitleLabel];
    [_hotTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self);
    }];
    
    //热搜内容
    _hotContentTagView = [[ZTUITagView alloc] initWithWidth:kScreenWidth - 40];
    _hotContentTagView.delegate = self;
    [self addSubview:_hotContentTagView];
    [_hotContentTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_hotTitleLabel);
        make.top.mas_equalTo(_hotTitleLabel.mas_bottom);
    }];

}


- (void)initHistoryKeywordView{
    //搜索历史标题View
    _historyTitleView = [[UIView alloc] init];
    [self addSubview:_historyTitleView];
    [_historyTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_hotContentTagView.mas_bottom);
        make.left.right.mas_equalTo(_hotTitleLabel);
        make.height.mas_equalTo(50);
    }];
    //标题
    _historyTitleLabel = [[UILabel alloc] init];
    _historyTitleLabel.font = kFontText16;
    _historyTitleLabel.textColor = kColorDarkGreen;
    _historyTitleLabel.text= L(@"search_local_title");
    [_historyTitleView addSubview:_historyTitleLabel];
    [_historyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_historyTitleView);
        make.centerY.mas_equalTo(_historyTitleView.mas_centerY);
    }];
    // 编辑按钮
    _historyEditBtn = [[UIButton alloc] init];
    [_historyEditBtn setTitleColor:kColorBlack forState:UIControlStateNormal];
    [_historyEditBtn setTitle:L(@"edit") forState:UIControlStateNormal];
    [_historyEditBtn addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_historyTitleView addSubview:_historyEditBtn];
    [_historyEditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_historyTitleView);
        make.centerY.mas_equalTo(_historyTitleView.mas_centerY);
    }];
    
    //历史搜索关键词内容
    _historyContentTagView = [[ZTUITagView alloc] initWithWidth:kScreenWidth -40];
    _historyContentTagView.delegate = self;
    [self addSubview:_historyContentTagView];
    [_historyContentTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_historyTitleView);
        make.top.mas_equalTo(_historyTitleView.mas_bottom);
    }];
}

- (void)setHotKeywordArray:(NSArray<NSString *> *)hotKeywordArray{
    _hotKeywordArray = hotKeywordArray;
    [_hotContentTagView tagViewDataArray:hotKeywordArray];
}

- (void)setHistoryKeywordArray:(NSArray<NSString *> *)historyKeywordArray{
    _historyKeywordArray = historyKeywordArray;
    [_historyContentTagView tagViewDataArray:historyKeywordArray];
    _historyContentTagView.editing = _editing;
}

- (void)buttonClickEvent:(UIButton*)button{
    _editing = !_editing;
    [_historyEditBtn setTitle:_editing? L(@"done") : L(@"edit") forState:UIControlStateNormal];
    _historyContentTagView.editing = _editing;
}

#pragma mark -ZTUITagViewDelegate
- (void)tagViewDidSelected:(ZTUITagView *)tagView index:(NSInteger)index{
    if([_childViewDelegate respondsToSelector:@selector(searchKeywordView:tagViewDidSelected:index:)]){
        [_childViewDelegate searchKeywordView:self tagViewDidSelected:tagView index:index];
    }
}

- (void)tagViewDidEdit:(ZTUITagView *)tagView index:(NSInteger)index{
    if([_childViewDelegate respondsToSelector:@selector(searchKeywordView:tagViewDidEdit:index:)]){
        [_childViewDelegate searchKeywordView:self tagViewDidEdit:tagView index:index];
    }
}

#pragma mark -UIScrollerView事件

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(!self.dragging){//当前控件不是正在拖动，事件交给下一个响应者（父控件）
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(!self.dragging){//当前控件不是正在拖动，事件交给下一个响应者（父控件）
        [self.nextResponder touchesEnded: touches withEvent:event];
    }
}

@end
