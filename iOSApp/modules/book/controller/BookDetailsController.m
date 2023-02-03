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
#import "BookDetailsViewModel.h"
#import "ArticleDetailsController.h"

@interface BookDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) BookHeaderView *bookHeaderView;
@property(nonatomic,strong) BookDetailsViewModel *viewModel;
@end

@implementation BookDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [UIBarHelper navigationBarBackgroundShadowImage:[UIImage imageWithSize:CGSizeMake(1, 1) color:[UIColor clearColor] cornerRadius:0] controller:self];
    [self initDataNotify];
    [self initHeaderView];
    [self initTableView];
    [self initData];
}

- (void)initDataNotify{
    _viewModel = [[BookDetailsViewModel alloc] init];
    [self observe:_viewModel notify:^(id  _Nonnull observable, NSString * _Nonnull keyPath) {
        [self->_tableView reloadData];
    }];
}

- (void)initHeaderView{
    _bookHeaderView = [[BookHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 230)];
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
}

- (void)initData{
    [_viewModel getBookArticleList:_bookData.bid bookId:_bookData.bid];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BookDetailsCell";
    BookDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[BookDetailsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    cell.articleData = [_viewModel.dataArray objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger bookId = _bookData.bid;
    ArticleData *articleData =  [_viewModel.dataArray objectAtIndex:indexPath.row];
    __block StudyData *studyData = articleData.studyData;
    
    ArticleDetailsController *controller = [[ArticleDetailsController alloc] init];
    MJWeakSelf
    [controller setProgressUpdateBlock:^(CGFloat progress) {
        if(studyData){
            studyData.progress = progress;
        }else{
            studyData = [[StudyData alloc] init];
            studyData.progress = progress;
            studyData.articleId = articleData.aid;
            studyData.bookId = bookId;
        }
        [weakSelf.viewModel insertOrUpdate:studyData];
    }];
    controller.articleData = articleData;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
