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
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self initDataNotify];
    [self initHeaderView];
    [self initTableView];
    [self initNavigationItem];
    [self loadData];
}

#pragma mark -init

- (void)initDataNotify{
    _homeViewModel = [[HomeViewModel alloc] init];
    MJWeakSelf
    [self observe:_homeViewModel notify:^(HomeViewModel *observable, NSString *keyPath) {
        NSLog(@"----keyPath:%@",keyPath);

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

- (void)initNavigationItem{
    
    //右侧按钮
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_search"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
    self.navigationItem.title = L(@"tab_home");
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark -selector

- (void)rightBarButtonAction{
    SearchController *controller = [[SearchController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
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
    cell.cellChildClickBlock = ^(UIView * _Nonnull view) {
        [self.homeViewModel collectOrCancelArticle:data.aid collect:!data.collect];
    };
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)dealloc{
    [_bannerView releaseResource];
}
@end
