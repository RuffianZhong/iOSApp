//
//  ProjectController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "ProjectController.h"
#import "ArtcleListController.h"
#import "ZTUITabView.h"
#import "ZTUIPageView.h"
#import "CategoryData.h"
#import "ProjectViewModel.h"

@interface ProjectController ()<ZTUIPageViewDelegate,ZTUITabViewDelegate>

@property(nonatomic,strong) ProjectViewModel *projectViewModel;
@property(nonatomic,strong) ZTUITabView *tabView;
@property(nonatomic,strong) ZTUIPageView *pageView;

@end

@implementation ProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    [self initDataNotify];
    [self initTabView];
    [self initPageView];
    [self getCategoryList];
}

- (void)initNavigationItem{
    [self setNavigationBarHiden:YES];
}


- (void)initTabView{
    _tabView = [[ZTUITabView alloc] init];
    _tabView.backgroundColor = kColorDarkGreen;
    _tabView.delegate = self;
    [_tabView.tabScrollerView setContentInsetAdjustmentBehaviorNO];
    [self.view addSubview:_tabView];
    [_tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset([UIBarHelper statusBarHeight]);
        make.left.mas_equalTo(self.view);
    }];
}


- (void)initPageView{
    _pageView = [[ZTUIPageView alloc] initWithController:self];
    _pageView.delegate = self;
    [self.view addSubview:_pageView];
    [_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(_tabView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

- (void)initDataNotify{
    _projectViewModel = [[ProjectViewModel alloc] init];
    WeakSelf
    [self observe:_projectViewModel notify:^(ProjectViewModel *observable, NSString *keyPath) {
        [weakSelf updateUI:observable keyPath:keyPath];
    }];
}

- (void)getCategoryList{
    [_projectViewModel getCategoryList];
}


-(void)updateUI:(ProjectViewModel *)projectViewModel keyPath:(NSString*) keyPath{
    if([keyPath isEqual:@"categoryArray"]){
        [_pageView pageViewDataArray:projectViewModel.categoryArray];
        [_pageView pageViewSelectIndex:0];
    }else if([keyPath isEqual:@"titleArray"]){
        [_tabView tabViewDataArray:projectViewModel.titleArray];
        [_tabView tabViewSelectIndex:0];
    }
}


#pragma mark -ZTUIPageViewDelegate
- (UIViewController *)pageViewChildViewController:(ZTUIPageView *)pageView index:(NSInteger)index{
    
    ArtcleListController *controller = [[ArtcleListController alloc] init];
    controller.categoryId = _projectViewModel.categoryArray[index].cid;
    
    return controller;
}

- (void)pageViewDidSelected:(ZTUIPageView *)pageView index:(NSInteger)index{
    [_tabView tabViewSelectIndex:index];
}

#pragma mark -ZTUITabViewDelegate
- (void)tabViewDidSelected:(ZTUITabView *)tabView index:(NSInteger)index{
    [_pageView pageViewSelectIndex:index];
}

- (void)dealloc{
    [_pageView releaseResource];
}

@end
