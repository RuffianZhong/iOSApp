//
//  KnowledgeContentController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import "KnowledgeContentController.h"
#import "KnowledgeContentCell.h"


@interface KnowledgeContentController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation KnowledgeContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView]; 
    [_tableView reloadData];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;//自动计算高度
    _tableView.estimatedRowHeight = 50;//估算高度
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
   
    
    static NSString *identifier = @"KnowledgeContentCell";
    KnowledgeContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[KnowledgeContentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
//    cell.data = [_artcleListViewModel.artcleArray objectAtIndex:indexPath.row];
//    cell.title = @"title";
//    cell.tagArray = _array;
    [cell setTitle:@"title" tagArray:_array];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}


@end
