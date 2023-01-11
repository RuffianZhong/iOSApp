//
//  ArtcleListController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import "ArtcleListController.h"
#import "ArtcleCell.h"
#import "ArtcleListViewModel.h"

@interface ArtcleListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) ArtcleListViewModel *artcleListViewModel;

@end

@implementation ArtcleListController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    MJWeakSelf;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}


- (void)initDataNotify{
    _artcleListViewModel = [[ArtcleListViewModel alloc] init];
    MJWeakSelf
    [self observe:_artcleListViewModel notify:^(ArtcleListViewModel *observable, NSString *keyPath) {
        [weakSelf updateUI:observable keyPath:keyPath];
    }];
}

-(void)updateUI:(ArtcleListViewModel *)artcleListViewModel keyPath:(NSString*) keyPath{

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
    ArtcleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ArtcleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.data = [_artcleListViewModel.artcleArray objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


@end
