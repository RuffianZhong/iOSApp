//
//  BannerView.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import "BannerView.h"
#import "BannerData.h"

@interface BannerView()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *loopScrollerView;
@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) NSMutableArray<BannerData*> *dataArray;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) int loopIndex;
@property(nonatomic,assign) int loopCount;
@property(nonatomic,assign) int index;//真实index

@end

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //自定义子控件初始化逻辑
        [self initLoopScrollerView];
        [self initPageControl];
    }
    return self;
}

- (void)initLoopScrollerView{
    _loopScrollerView = [[UIScrollView alloc] init];
    _loopScrollerView.pagingEnabled = YES;
    _loopScrollerView.showsHorizontalScrollIndicator = NO;
    _loopScrollerView.bounces = NO;
    _loopScrollerView.clipsToBounds = NO;
    _loopScrollerView.delegate = self;
    [self addSubview:_loopScrollerView];
    [_loopScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(self);
    }];
    
}

- (void)initPageControl{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];//默认颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];//选中颜色
    _pageControl.numberOfPages = 0;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
}

- (void)initBannerImage:(NSMutableArray<BannerData*> *)bannerArray{
    
    if(!bannerArray) return;
    
    UIImageView *imageView = nil;
    CGFloat offsetX = 0;
    for (int i = 0; i < _loopCount; i++) {
        offsetX = i * self.frame.size.width;
        CGRect frame = CGRectMake(offsetX, 0, self.frame.size.width, self.frame.size.height);
        
        imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds = YES;
        [imageView setImageWithURL:bannerArray[i % bannerArray.count].imagePath];
        
        [_loopScrollerView addSubview:imageView];
    }
}

- (void)updateBanner:(NSMutableArray<BannerData*> *)bannerArray{
    
    NSInteger dataCount = bannerArray.count;
    _dataArray = bannerArray;
    _loopCount = (int)dataCount * 3;
    
    _loopScrollerView.contentSize = CGSizeMake(self.frame.size.width * _loopCount, self.frame.size.height);
    _pageControl.numberOfPages = dataCount;

    [self initBannerImage:bannerArray];
    [self initLoop];
}


/// 用户触发：滚动停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewEndScrollLogic:scrollView];
}

///  程序触发：滚动停止（必须带动画，否则不回调）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewEndScrollLogic:scrollView];
}

#pragma mark - Loop

- (void)initLoop{
    
    _loopIndex = [self resumeMidIndex:NO];
    _index = _loopIndex % _dataArray.count;
    
    _loopScrollerView.contentOffset = CGPointMake(_loopIndex * kScreenWidth, 0);
    
    if(!_timer){
        _timer = [NSTimer timerWithTimeInterval:2.0f target:self selector:@selector(timerTask) userInfo:nil repeats:YES];
        //NSDefaultRunLoopMode:拖拽时暂停
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)timerTask{
    [_loopScrollerView setContentOffset: CGPointMake((_loopIndex + 1) * kScreenWidth, 0) animated:YES];
}

/// SV 停止滚动的处理逻辑
- (void)scrollViewEndScrollLogic:(UIScrollView *)scrollView{
    
    int index = scrollView.contentOffset.x / kScreenWidth;
    
    //_loopIndex
    _loopIndex = [self computeLoopIndex:index];
    
    //_index
    _index = _loopIndex % ((int)_dataArray.count);
    
    //内容
    CGPoint point = CGPointMake(_loopIndex * kScreenWidth, 0);
    _loopScrollerView.contentOffset = point;    //[_loopScrollerView setContentOffset:point animated:YES];

    //指示器
    [_pageControl setCurrentPage:_index];
}

/// 计算循环滚动的下标
-(int)computeLoopIndex:(int)index {
    ///到达第一个数据
    if (index == 0) index = [self resumeMidIndex:NO];

    ///到达最后一个数据
    if (index == _loopCount - 1) index = [self resumeMidIndex:YES];
    
    return index;
}

///恢复到中间下标
///依据条件数据 开始/结束 处
///默认恢复到数据开始下标
-(int) resumeMidIndex:(BOOL)end{
   ///除后取整
   int minIndex = _loopCount / 2;

   ///余数
   int remainder = minIndex % _dataArray.count;

   ///1.恢复到开始：减去余数
   if (!end) {
     minIndex = minIndex - remainder;
   }

   ///2.恢复到结束：减去余数 - 1（再往前一个）
   if (end) {
     minIndex = minIndex - remainder - 1;
   }
   return minIndex;
 }


@end
