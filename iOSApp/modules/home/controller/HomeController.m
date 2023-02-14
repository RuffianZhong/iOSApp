//
//  HomeController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "HomeController.h"
#import "BannerView.h"
#import "ArticleCell.h"
#import "HomeViewModel.h"
#import "SearchController.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) BannerView *bannerView;

@property(nonatomic,strong) HomeViewModel *homeViewModel;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataNotify];
    [self initHeaderView];
    [self initTableView];
    [self initNavigationItem];
    [self loadData];
}

#pragma mark -init

- (void)initDataNotify{
    _homeViewModel = [[HomeViewModel alloc] init];
    WeakSelf
    [self observe:_homeViewModel notify:^(HomeViewModel *observable, NSString *keyPath) {
        [weakSelf updateUI:observable keyPath:keyPath];
    }];
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
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    WeakSelf
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

- (void)initNavigationItem{
    [self setNavigationLeftImage:[UIImage new]];
    [self setNavigationTitle:L(@"tab_home")];
    [self setNavigationRightImage:[UIImage imageNamed:@"ic_search"]];
    WeakSelf
    [self setNavigationRightBarHandler:^(NSInteger index) {
        SearchController *controller = [[SearchController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark -selector

-(void)updateUI:(HomeViewModel *)homeViewModel keyPath:(NSString*) keyPath{

    if(homeViewModel.refreshState == 1){
        [_tableView.mj_header endRefreshing];
    }else if(homeViewModel.refreshState == 2){
        [_tableView.mj_footer endRefreshing];
    }
    
    [_bannerView updateBanner:homeViewModel.bannerArray];
    [_tableView reloadData];
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
    ArticleData *data = [_homeViewModel.artcleArray objectAtIndex:indexPath.row];
    
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ArticleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.data = data;
    WeakSelf
    cell.cellChildClickBlock = ^(UIView * _Nonnull view) {
        [weakSelf.homeViewModel collectOrCancelArticle:data.aid collect:!data.collect];
    };
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)dealloc{
    [_bannerView releaseResource];
}
@end
