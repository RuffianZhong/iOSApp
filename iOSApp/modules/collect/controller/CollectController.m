//
//  CollectController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import "CollectController.h"
#import "ArticleCell.h"
#import "CollectViewModel.h"
#import "ZTUIAlertController.h"

@interface CollectController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) CollectViewModel *collectViewModel;
@end

@implementation CollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataNotify];
    [self initNavigationBar];
    [self initTableView];
    [self loadData];
}

#pragma mark -init

- (void)initDataNotify{
    _collectViewModel = [[CollectViewModel alloc] init];
    WeakSelf
    [self observe:_collectViewModel notify:^(CollectViewModel *observable, NSString *keyPath) {
        [weakSelf updateUI:observable keyPath:keyPath];
    }];
}

- (void)initNavigationBar{
    [self setNavigationTitle:L(@"collect")];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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

-(void)updateUI:(CollectViewModel *)collectViewModel keyPath:(NSString*) keyPath{

    if(collectViewModel.refreshState == 1){
        [_tableView.mj_header endRefreshing];
    }else if(collectViewModel.refreshState == 2){
        [_tableView.mj_footer endRefreshing];
    }
    
    [_tableView reloadData];
}

#pragma mark -data

- (void)loadData{
    [_collectViewModel getArtcleListWithRefresh:YES];
}

- (void)loadMoreData{
    [_collectViewModel getArtcleListWithRefresh:NO];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _collectViewModel.artcleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CollectListCell";
    ArticleData *data = [_collectViewModel.artcleArray objectAtIndex:indexPath.row];
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ArticleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.data = data;
    WeakSelf
    cell.cellChildClickBlock = ^(UIView * _Nonnull view) {
        [weakSelf cancelCollectArticle:data];
    };
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (void)cancelCollectArticle:(ArticleData*)articleData{
    ZTUIAlertController *alert = [ZTUIAlertController alertControllerWithTitle:L(@"tips_msg") message:L(@"collect_content")];
    [alert cancelActionTitle:L(@"cancel")];
    WeakSelf
    [alert confirmActionTitle:L(@"confirm") handler:^{
        [weakSelf.collectViewModel cancelCollectArticle:articleData.aid result:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
            [HUDUtils showToastMsg:msg forView:weakSelf.view];
        }];
    }];
    [alert showWithController:self];
}


@end
