//
//  UITabView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/7.
//

#import "UITabView.h"
#import "UITabChildView.h"

@interface UITabView()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *tabScrollerView;
@property(nonatomic,strong) NSMutableArray<UITabChildView*> *viewArray;

@property(nonatomic,strong) NSMutableArray<NSString*> *dataArray;
@end

@implementation UITabView


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
    _tabScrollerView.delegate = self;
    [self addSubview:_tabScrollerView];
    [_tabScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(self);
    }];
}


- (void)initTabScrollerViewChild:(NSMutableArray *)dataArray{
    
    if(!dataArray) return;

    UITabChildView *tabChild = nil;
    CGFloat offsetX = 0;
    CGFloat width = 150;
    
    for (int i = 0; i < dataArray.count; i++) {
        offsetX = i * width;
        CGRect frame = CGRectMake(offsetX, 0, width, self.frame.size.height);
        
        tabChild = [[UITabChildView alloc] initWithFrame:frame];
        tabChild.backgroundColor=[UIColor blueColor];
        [tabChild.button setTitle:dataArray[i] forState:UIControlStateNormal];
        [tabChild.button addTarget:self action:@selector(onTabClick:) forControlEvents:UIControlEventTouchUpInside];
        [_viewArray addObject:tabChild];
        [_tabScrollerView addSubview:tabChild];
    }

}

- (void)onTabClick:(UIButton*)button{

    UITabChildView *targetTabChild = (UITabChildView*)[button superview];
 
    UITabChildView *tabChild;
    for (int i = 0; i < _viewArray.count; i++) {
        tabChild = _viewArray[i];
        tabChild.select = tabChild == targetTabChild;
    }

    [self scrollTabChildView:targetTabChild];
}

- (void)scrollTabChildView:(UIView*)tabChildView{
    
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

- (void)updateTabView:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    _tabScrollerView.contentSize = CGSizeMake(150 * dataArray.count, self.frame.size.height);
    
    [self initTabScrollerViewChild:dataArray];
}



@end


