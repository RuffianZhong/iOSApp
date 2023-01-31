//
//  KnowledgeChildController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/30.
//

#import "KnowledgeChildController.h"
#import "ArtcleListController.h"
#import "ZTUITabView.h"
#import "ZTUIPageView.h"

@interface KnowledgeChildController ()<ZTUIPageViewDelegate,ZTUITabViewDelegate>
@property(nonatomic,strong) ZTUITabView *tabView;
@property(nonatomic,strong) ZTUIPageView *pageView;
@end

@implementation KnowledgeChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initNavigationItem];
    [self initTabView];
    [self initPageView];
    [self initUIData];

}

- (void)initNavigationItem{
    [UIBarHelper navigationBarBackgroundColor:kColorDarkGreen controller:self];
    [UIBarHelper navigationBarBackgroundShadowImage:[UIImage imageWithSize:CGSizeMake(1, 1) color:kColorDarkGreen cornerRadius:0] controller:self];
    [UIBarHelper statusBarBackgroundColor:kColorDarkGreen];
    
    self.navigationItem.title = _categoryData.name;
}


- (void)initTabView{
    _tabView = [[ZTUITabView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    _tabView.backgroundColor = kColorDarkGreen;
    _tabView.delegate = self;
    [_tabView.tabScrollerView setContentInsetAdjustmentBehaviorNO];
    [self.view addSubview:_tabView];
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


-(void)initUIData{
    //pageView
    [_pageView pageViewDataArray:_categoryData.childArray];
    [_pageView pageViewSelectIndex:_index];
    
    //tabView
    NSMutableArray<NSString*>* titleArray= [NSMutableArray array];
    for(int i = 0;i < _categoryData.childArray.count; i++){
        [titleArray addObject:_categoryData.childArray[i].name];
    }
    [_tabView tabViewDataArray:titleArray];
    [_tabView tabViewSelectIndex:_index];
    
}


#pragma mark -ZTUIPageViewDelegate
- (UIViewController *)pageViewChildViewController:(ZTUIPageView *)pageView index:(NSInteger)index{
    
    ArtcleListController *controller = [[ArtcleListController alloc] init];
    controller.categoryId = _categoryData.childArray[index].cid;
    
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
