//
//  ProjectController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "ProjectController.h"
#import "BookController.h"
#import "UITabView.h"

@interface ProjectController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>


@property(nonatomic,strong) UIPageViewController *pageViewController;

@property(nonatomic,strong) UISegmentedControl *segmentedControl;

@property(nonatomic,strong) NSMutableArray<NSString*> *dataArray;

@property(nonatomic,strong) UITabView *tabView;



@end

@implementation ProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initSegmentedControl];
    
    
    _dataArray = [NSMutableArray array];
    for (int i = 0; i<15; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"这是第个%i内容", i]];
    }
    
    [self initPageViewController];
    [self initTabView];
    
}

- (void)initTabView{
    _tabView = [[UITabView alloc] initWithFrame:CGRectMake(0, 500, kScreenWidth, 60)];
    [self.view addSubview:_tabView];
//    [_tabView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(200);
//        make.width.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.view).offset(50);
//    }];
    
    [_tabView updateTabView:_dataArray];
}



#pragma mark - UIPageViewControllerDataSource
//前一个 VC ，返回 nil 时表示达到边缘
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self indexOfViewController:(BookController*)viewController];

    if(index == 0 || (index == NSNotFound)){
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

//后一个 VC ，返回 nil 时表示达到边缘
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index = [self indexOfViewController:(BookController*)viewController];
    
    if(index == NSNotFound) return nil;
    
    index++;

    if(index == self.dataArray.count){
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}


- (BookController *)viewControllerAtIndex:(NSUInteger)index {
    if((self.dataArray.count ==0 ) ||(index >= self.dataArray.count)) return nil;
    BookController *vc = [[BookController alloc] init];
    vc.desc = [self.dataArray objectAtIndex:index];
    return vc;
}

#pragma mark - 数组元素值，得到下标值

- (NSUInteger)indexOfViewController:(BookController *)viewController {
    return [self.dataArray indexOfObject:viewController.desc];
}



- (void)initPageViewController{
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    BookController *dataVC = [self viewControllerAtIndex:0];
    [self.pageViewController setViewControllers:@[dataVC]
                                         direction:UIPageViewControllerNavigationDirectionForward
                                          animated:NO
                                        completion:nil];
    
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    [_pageViewController setToolbarItems:nil];
    
    _pageViewController.view.frame = CGRectMake(0, 100, kScreenWidth, 300);
    // 添加视图控制器、视图。
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
}


// 手势导航结束后调用该方法。
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"%s",__func__);
    // 使用completed参数区分成功导航和中止导航。
//    if (completed) {
//        self.currentIndex = self.nextIndex;
//    }
    
}


-(UILabel*)initlabel{
    UILabel *label=[[UILabel alloc] init];
    label.text = @"标题第";
    
    return label;
}


@end
