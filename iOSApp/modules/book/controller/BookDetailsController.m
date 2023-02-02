//
//  BookDetailsController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import "BookDetailsController.h"
#import "BookHeaderView.h"
#import "BookDetailsCell.h"
#import "StudyData.h"



@interface BookDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) BookHeaderView *bookHeaderView;
@end

@implementation BookDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initHeaderView];
    [self initTableView];
}

- (void)initHeaderView{
    _bookHeaderView = [[BookHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    [self.view addSubview:_bookHeaderView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.view);
//        make.left.top.mas_equalTo(self.view);
//    }];
    
    [_bookHeaderView setBookData:_bookData];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _bookHeaderView;
    _tableView.rowHeight = UITableViewAutomaticDimension;//自动计算高度
    _tableView.estimatedRowHeight = 100;//估算高度
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
    
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return  _homeViewModel.artcleArray.count;
    return  10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BookDetailsCell";
    BookDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[BookDetailsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
//    cell.data = [_homeViewModel.artcleArray objectAtIndex:indexPath.row];
    StudyData *study = [[StudyData alloc] init];
    study.progress = 0.3;
    study.time =1675329048;
    
    ArticleData *articleData = [[ArticleData alloc] init];
    articleData.title = @"hello";
    articleData.studyData = study;
    cell.articleData = articleData;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

@end
