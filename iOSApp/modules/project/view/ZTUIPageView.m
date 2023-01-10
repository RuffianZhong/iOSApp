//
//  ZTUIPageView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/9.
//

#import "ZTUIPageView.h"

@interface ZTUIPageView()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property(nonatomic,strong) UIPageViewController *pageViewController;
//即将到达的index（不一定移动成功）
@property(nonatomic,assign) NSInteger willTransitionIndex;
//下标名称列表（辅助管理下标）
@property(nonatomic,strong) NSMutableArray<NSString*> *indexNameArray;
//缓存controller
@property(nonatomic,strong) NSMutableDictionary *controllerCache;
@end

@implementation ZTUIPageView

static const char *zt_key_index_property = "zt_key_index_property";


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _index = -1;
        _indexNameArray = [NSMutableArray array];
        _controllerCache = [NSMutableDictionary dictionary];
        //自定义子控件初始化逻辑
        [self initPageViewController];
    }
    return self;
}


- (void)initPageViewController{
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    _pageViewController.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    [self addSubview:_pageViewController.view];
}


#pragma mark - UIPageViewControllerDataSource
//前一个 VC ，返回 nil 时表示达到边缘
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self indexOfViewController: viewController];

    if(index == 0 || (index == NSNotFound)){
        return nil;
    }

    index--;
    return [self viewControllerAtIndex:index];
}

//后一个 VC ，返回 nil 时表示达到边缘
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    NSInteger index = [self indexOfViewController:viewController];

    if(index == NSNotFound) return nil;

    index++;

    if(index == _indexNameArray.count){
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate

//页面即将切换
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    _willTransitionIndex = [self indexOfViewController:[pendingViewControllers firstObject]];
}

//页面已经切换
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        _index = _willTransitionIndex;
        if([_delegate respondsToSelector:@selector(pageViewDidSelected:index:)]){
            [_delegate pageViewDidSelected:self index:_index];
        }
    }
}

#pragma mark -辅助方法

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if((_indexNameArray.count ==0 ) ||(index >= _indexNameArray.count)) return nil;
       
    NSString *indexStr = [_indexNameArray objectAtIndex:index];
    
    UIViewController *controller = _controllerCache[indexStr];
    
    if(controller) return controller;//直接返回缓存数据
    
    
    if([_delegate respondsToSelector:@selector(pageViewChildViewController:index:)]){
        controller = [_delegate pageViewChildViewController:self index:index];
    }
    
    if(controller){
        //动态添加属性值
        objc_setAssociatedObject(controller, zt_key_index_property, indexStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        //添加到缓存
        _controllerCache[indexStr] = controller;
    }
    return controller;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    NSString *indexName = objc_getAssociatedObject(viewController, zt_key_index_property);
    return [_indexNameArray indexOfObject:indexName];
}


#pragma mark -对外方法

- (void)pageViewDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    
    for (int i = 0; i < dataArray.count; i++) {
        [_indexNameArray addObject:[NSString stringWithFormat:@"indexName_%i", i]];
    }
}


- (void)pageViewSelectIndex:(NSInteger)index{
        
    if(index == _index) return;
    
    //滚动方向
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if(index < _index){
        direction = UIPageViewControllerNavigationDirectionReverse;
    }

    _index = index;
    
    UIViewController *controller = [self viewControllerAtIndex:index];

    [_pageViewController setViewControllers:@[controller]
                                         direction:direction
                                          animated:YES
                                        completion:nil];
}

@end
