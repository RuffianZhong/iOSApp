//
//  ArtcleListController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import "ArticleListController.h"
#import "ArticleCell.h"
#import "ArticleListViewModel.h"
#import "ArticleDetailsController.h"

@interface ArticleListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) ArticleListViewModel *artcleListViewModel;

@end

@implementation ArticleListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHiden:YES];
    [self initDataNotify];
    [self initTableView];
    [self loadData];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;//自动计算高度
    _tableView.estimatedRowHeight = 100;//估算高度

    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
    
    WeakSelf;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}


- (void)initDataNotify{
    _artcleListViewModel = [[ArticleListViewModel alloc] init];
    WeakSelf
    [self observe:_artcleListViewModel notify:^(ArticleListViewModel *observable, NSString *keyPath) {
        [weakSelf updateUI:observable keyPath:keyPath];
    }];
}

-(void)updateUI:(ArticleListViewModel *)artcleListViewModel keyPath:(NSString*) keyPath{

    if(artcleListViewModel.refreshState == 1){
        [_tableView.mj_header endRefreshing];
    }else if(artcleListViewModel.refreshState == 2){
        [_tableView.mj_footer endRefreshing];
    }
    
    [_tableView reloadData];
}

#pragma mark -data

- (void)loadData{
    [_artcleListViewModel getArtcleListWithCategoryId:_categoryId refresh:YES];
}

- (void)loadMoreData{
    [_artcleListViewModel getArtcleListWithCategoryId:_categoryId refresh:NO];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _artcleListViewModel.artcleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ProjectArtcleListCell";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ArticleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.data = [_artcleListViewModel.artcleArray objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleDetailsController *controller = [[ArticleDetailsController alloc] init];
    controller.articleData = [_artcleListViewModel.artcleArray objectAtIndex:indexPath.row];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
