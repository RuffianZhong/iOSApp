//
//  HomeController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "HomeController.h"
#import "BannerView.h"
#import "ArtcleCell.h"
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
    
    [self initDataNotify];
    [self initHeaderView];
    [self initTableView];
    [self initFloatButton];
    
    [self loadData];
}

- (void)initDataNotify{
    _homeViewModel = [[HomeViewModel alloc] init];
    MJWeakSelf
    [self observe:_homeViewModel notify:^(HomeViewModel *observable, NSString *keyPath) {
        [weakSelf updateUI:observable keyPath:keyPath];
    }];
}

-(void)updateUI:(HomeViewModel *)homeViewModel keyPath:(NSString*) keyPath{

    if(homeViewModel.refreshState == 1){
        [_tableView.mj_header endRefreshing];
    }else if(homeViewModel.refreshState == 2){
        [_tableView.mj_footer endRefreshing];
    }
    
    [_bannerView updateBanner:homeViewModel.bannerArray];
    [_tableView reloadData];
}


- (void)initTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _bannerView;
    _tableView.rowHeight = UITableViewAutomaticDimension;//自动计算高度
    _tableView.estimatedRowHeight = 100;//估算高度

    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
    
    MJWeakSelf;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
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
        make.right.mas_equalTo(_tableView.mas_right).offset(-20);
        make.bottom.mas_equalTo(_tableView.mas_bottom).offset(-20);
    }];
}

#pragma mark -data

- (void)loadData{
    [_homeViewModel getArtcleListWithRefresh:YES];
    [_homeViewModel getBannerList];
}

- (void)loadMoreData{
    [_homeViewModel getArtcleListWithRefresh:NO];
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


@end
