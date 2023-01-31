//
//  ZTUITabView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import "ZTUITabView.h"
#import "ZTUITabChildView.h"


@interface ZTUITabView()<ZTUITabChildViewDelegate>
@property(nonatomic,strong) NSMutableArray<ZTUITabChildView*> *viewArray;
@end

@implementation ZTUITabView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //自定义子控件初始化逻辑
        _viewArray = [NSMutableArray array];

        [self initTabScrollerView];
    }
    return self;
}

- (void)initTabScrollerView{
    _tabScrollerView = [[UIScrollView alloc] init];
    _tabScrollerView.pagingEnabled = NO;
    _tabScrollerView.showsHorizontalScrollIndicator = NO;
    _tabScrollerView.bounces = NO;
    _tabScrollerView.clipsToBounds = NO;
    [self addSubview:_tabScrollerView];
    [_tabScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(self);
    }];
}


- (void)initTabScrollerViewChild:(NSMutableArray<NSString*> *)dataArray{
    
    if(!dataArray) return;

    CGRect frame;
    CGFloat offsetX = 0;
    ZTUITabChildView *tabChild = nil;
    for (int i = 0; i < dataArray.count; i++) {
        
        tabChild = [[ZTUITabChildView alloc] init];
        tabChild.delegate = self;
        [tabChild setTitle:dataArray[i]];
        
        frame = CGRectMake(offsetX, 0, tabChild.viewWidth, self.frame.size.height);
        tabChild.frame = frame;
        offsetX += tabChild.viewWidth;
                
        [_viewArray addObject:tabChild];
        [_tabScrollerView addSubview:tabChild];
    }
    
    _tabScrollerView.contentSize = CGSizeMake(offsetX, self.frame.size.height);
}


- (void)onTabChildViewSelected:(ZTUITabChildView *)tabChildView notifyDelegate:(BOOL)notify{
    
    BOOL isTarget = NO;
    ZTUITabChildView *tabChild;
    for (int i = 0; i < _viewArray.count; i++) {
        tabChild = _viewArray[i];
        isTarget = tabChild == tabChildView;
        tabChild.select = isTarget;
        if(isTarget){
            _index = i;
            if(notify && [_delegate respondsToSelector:@selector(tabViewDidSelected:index:)]){
                [_delegate tabViewDidSelected:self index:_index];
            }
        }
    }

    [self scrollTabChildView:tabChildView];
}

- (void)scrollTabChildView:(UIView*)tabChildView{
    
    //可滚动内容小于控件宽度：无需滚动
    if(_tabScrollerView.contentSize.width <= self.frame.size.width) return;
    
    CGFloat offsetMin = 0;//最小内容偏移量
    CGFloat offsetMax = _tabScrollerView.contentSize.width - self.frame.size.width;//最大内容偏移量
    
    CGFloat currentOffsetX = _tabScrollerView.contentOffset.x;//当前内容偏移量
    
    CGFloat midX = self.frame.size.width / 2.f;
    
    CGRect tabViewFrame = [_tabScrollerView convertRect:tabChildView.frame toView:self];

    CGFloat diffOffset = (tabViewFrame.origin.x - midX) + (tabViewFrame.size.width / 2.f);

    CGFloat targetOffsetX = currentOffsetX + diffOffset;

    if(targetOffsetX < offsetMin){
        targetOffsetX = offsetMin;
    }
    
    if(targetOffsetX > offsetMax){
        targetOffsetX = offsetMax;
    }

    [_tabScrollerView setContentOffset: CGPointMake(targetOffsetX, 0) animated:YES];
}

#pragma mark - 对外方法
- (void)tabViewDataArray:(NSMutableArray<NSString*> *)dataArray{
    _dataArray = dataArray;
    [self initTabScrollerViewChild:dataArray];
}

- (void)tabViewSelectIndex:(NSInteger)index{
    ZTUITabChildView *tabChildView = _viewArray[index];
    [self onTabChildViewSelected:tabChildView notifyDelegate:NO];
}

#pragma mark - ZTUITabChildViewDelegate

- (void)tabChildViewDidClick:(ZTUITabChildView *)tabChildView{
    [self onTabChildViewSelected:tabChildView notifyDelegate:YES];
}

@end
