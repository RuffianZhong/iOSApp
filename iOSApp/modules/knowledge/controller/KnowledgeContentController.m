//
//  KnowledgeContentController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import "KnowledgeContentController.h"
#import "KnowledgeContentCell.h"
#import "KnowledgeViewModel.h"


@interface KnowledgeContentController ()<UITableViewDelegate,UITableViewDataSource,ZTUITagViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) KnowledgeViewModel *viewModel;

@end

@implementation KnowledgeContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataNotify];
    [self initTableView];
    [self initData];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;//自动计算高度
    _tableView.estimatedRowHeight = 50;//估算高度
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.delaysContentTouches = NO;//解决：按钮点击无按下效果


    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
    
}

- (void)initDataNotify{
    _viewModel = [[KnowledgeViewModel alloc] init];
    MJWeakSelf
    [self observe:_viewModel notify:^(KnowledgeViewModel *observable, NSString *keyPath) {
        [weakSelf.tableView reloadData];
    }];
}

- (void)initData{
    if(_type == 0){
        [_viewModel getCategoryList];
    }else{
        [_viewModel getNavList];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _type == 0 ? _viewModel.knowledgeData.categoryArray.count : _viewModel.knowledgeData.navArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"KnowledgeContentCell";
    KnowledgeContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[KnowledgeContentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //setData
    NSString *title = [_viewModel titleForIndex:indexPath.row withType:_type];
    NSArray<NSString*> *tagArray = [_viewModel tagArrayForIndex:indexPath.row withType:_type];
    [cell setTitle:title tagArray:tagArray];
    
    cell.tagView.delegate = self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - ZTUITagViewDelegate

- (void)tagViewDidSelected:(ZTUITagView *)tabView index:(NSInteger)index{
//    NSInteger count = _type == 0 ? _viewModel.knowledgeData.categoryArray.count : _viewModel.knowledgeData.navArray.count;
    
    NSLog(@"-----:%li",index);
}

@end
