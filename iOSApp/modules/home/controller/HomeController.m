//
//  HomeController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "HomeController.h"
#import "ArtcleData.h"
#import "BannerData.h"
#import "BannerView.h"
#import "ArtcleCell.h"
#import "HomeModel.h"
#import "HomeViewModel.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) BannerView *bannerView;
@property(nonatomic,strong) UIButton *floatButton;//悬浮按钮：搜索和回到顶部

@property(nonatomic,strong) HomeViewModel *homeViewModel;


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;

    [self initDataNotify];
    [self initHeaderView];
    [self initTableView];
    [self initFloatButton];
    
    [self initLoadData];
}

- (void)initLoadData{
    [_homeViewModel getArtcleList];
    [_homeViewModel getBannerList];
}

- (void)initDataNotify{
    _homeViewModel = [[HomeViewModel alloc] init];
//    __weak typeof(self) weakSelf = self;
    [self observe:_homeViewModel notify:^(HomeViewModel *observable, NSString *keyPath) {
//        [weakSelf updateUI:observable keyPath:keyPath];
        [self updateUI:observable keyPath:keyPath];
    }];
}

-(void)updateUI:(HomeViewModel *)homeViewModel keyPath:(NSString*) keyPath{

    if([keyPath isEqual:@"finishRefresh"]){
        [_tableView.mj_header endRefreshing];
    }
    
    [_bannerView updateBanner:homeViewModel.bannerArray];

    [_tableView reloadData];
}


- (void)initTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _bannerView;
    _tableView.rowHeight=UITableViewAutomaticDimension;//自动计算高度
    _tableView.estimatedRowHeight=100;//估算高度

    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.homeViewModel getArtcleList];
        [weakSelf.homeViewModel getBannerList];

       }];
}

- (void)initHeaderView{
    _bannerView = [[BannerView alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth, 250)];
    [self.view addSubview:_bannerView];
}

- (void)initFloatButton{
    _floatButton = [[UIButton alloc] init];
    _floatButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:_floatButton];
    [_floatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _homeViewModel.artcleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HomeListCell";
    ArtcleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ArtcleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.data = [_homeViewModel.artcleArray objectAtIndex:indexPath.row];
    return cell;
}


@end
