//
//  KnowledgeController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "KnowledgeController.h"
#import "ZTUITagView.h"
#import "ZTUIPageView.h"
#import "KnowledgeContentController.h"

@interface KnowledgeController ()<ZTUIPageViewDelegate>
@property(nonatomic,strong) ZTUITagView *tagView;
@property(nonatomic,strong) UISegmentedControl *segmentedControl;
@property(nonatomic,strong) ZTUIPageView *pageView;
@property(nonatomic,strong) NSArray *titleArray;
@end

@implementation KnowledgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhite;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _titleArray = [NSArray arrayWithObjects:L(@"tab_tree"), L(@"tab_nav"), nil];
    [self initSegmentedControl];
    [self initPageView];
}


- (void)initSegmentedControl{
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:_titleArray];
    _segmentedControl.frame = CGRectMake(0, 0, 100, 35);
    _segmentedControl.selectedSegmentIndex = 1;
    _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;//must:否则页面回退时崩溃
    [_segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentedControl;
}


- (void)initPageView{
    //initUI
    _pageView = [[ZTUIPageView alloc] initWithController:self];
    _pageView.delegate = self;
    [self.view addSubview:_pageView];
    [_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.view);
    }];
    //initData
    [_pageView pageViewDataArray:_titleArray];
    [_pageView pageViewSelectIndex:1];
}

#pragma mark -辅助函数

- (void)segmentedControlValueChanged:(UISegmentedControl*)segmentedControl{
    NSInteger selectedIndex = segmentedControl.selectedSegmentIndex;
    [_pageView pageViewSelectIndex:selectedIndex];
}

#pragma mark -ZTUIPageViewDelegate
- (UIViewController *)pageViewChildViewController:(ZTUIPageView *)pageView index:(NSInteger)index{
    KnowledgeContentController *controller = [[KnowledgeContentController alloc] init];
    controller.type = index;
    return controller;
}

- (void)pageViewDidSelected:(ZTUIPageView *)pageView index:(NSInteger)index{
    _segmentedControl.selectedSegmentIndex = index;
}

@end
