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
@property(nonatomic,strong) UIView *pView;
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) ZTUITagView *tagView;
@property(nonatomic,strong)  NSMutableArray *array;

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
    
    int i = 1;
    if(i == 1 ){
        [self initSegmentedControl];
        [self initPageView];
    }else{
        [self initTagView];
        [self initData];
    }
   
    

}


- (void)initSegmentedControl{
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:_titleArray];
    _segmentedControl.frame = CGRectMake(0, 0, 100, 35);
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentedControl;
}


- (void)initPageView{
    //initUI
    _pageView = [[ZTUIPageView alloc] init];
    _pageView.delegate = self;
    [self.view addSubview:_pageView];
    [_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.view);
    }];
    //initData
    [_pageView pageViewDataArray:_titleArray];
    [_pageView pageViewSelectIndex:0];
}

#pragma mark -辅助函数

- (void)segmentedControlValueChanged:(UISegmentedControl*)segmentedControl{
    NSInteger selectedIndex = segmentedControl.selectedSegmentIndex;
    NSLog(@"-----seltd:%li",selectedIndex);
        switch (selectedIndex) {
            case 0:
                break;
            case 1:
                break;
        }
}

#pragma mark -ZTUIPageViewDelegate
- (UIViewController *)pageViewChildViewController:(ZTUIPageView *)pageView index:(NSInteger)index{
    
    KnowledgeContentController *controller = [[KnowledgeContentController alloc] init];
//    controller.categoryId = _projectViewModel.categoryArray[index].cid;
    
    return controller;
}

- (void)pageViewDidSelected:(ZTUIPageView *)pageView index:(NSInteger)index{
    _segmentedControl.selectedSegmentIndex = index;
}

- (void)initTagView{
    
    _pView = [[UIView alloc] init];
    _pView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_pView];
    [_pView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
    }];
    
    
//    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _label = [[UILabel alloc] init];
    _label.text = @"label";
    _label.backgroundColor = [UIColor clearColor];
    [_pView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(_pView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    _tagView = [[ZTUITagView alloc] init];
//    _tagView = [[ZTUITagView alloc] initWithFrame:CGRectMake(20, 60, self.view.frame.size.width - 40, 0)];

    _tagView.backgroundColor = [UIColor redColor];
    [_pView addSubview:_tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
//        make.top.mas_equalTo(_label.mas_bottom);
//        make.width.mas_equalTo(self.view.frame.size.width - 40);
//        make.bottom.mas_equalTo(_pView.mas_bottom);
        
        make.left.mas_equalTo(_pView).offset(20);
                make.width.mas_equalTo(self.view.frame.size.width - 40);
        make.top.mas_equalTo(_label.mas_bottom).offset(20);
        make.bottom.mas_equalTo(_pView.mas_bottom).offset(-20);
    }];
}


- (void)initData{
    
    NSMutableArray *_array = [NSMutableArray array];
        [_array addObject:@"例如常量"];
        [_array addObject:@"基类"];
        [_array addObject:@"account_model"];
        [_array addObject:@"例如常量"];
        [_array addObject:@"网络"];
        [_array addObject:@"core"];
        [_array addObject:@"账户模块"];
        [_array addObject:@"全局通用控件"];
        [_array addObject:@"modules"];
        [_array addObject:@"本地数据"];
        [_array addObject:@"数据"];
        [_array addObject:@"本地core数据"];
        [_array addObject:@"--分割--"];
        [_array addObject:@"基类"];
        [_array addObject:@"account_model"];
        [_array addObject:@"例如常量"];
        [_array addObject:@"网络"];
        [_array addObject:@"core"];
        [_array addObject:@"账户模块"];
        [_array addObject:@"全局通用控件"];
        [_array addObject:@"modules"];
        [_array addObject:@"本地数据"];
        [_array addObject:@"数据"];
        [_array addObject:@"本地core数据"];
    
    [_tagView tagViewDataArray:_array];

}

@end
