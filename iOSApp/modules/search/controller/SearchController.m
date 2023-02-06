//
//  SearchController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import "SearchController.h"
#import "SearchKeywordView.h"
#import "ArticleCell.h"
#import "SearchViewModel.h"

@interface SearchController ()<UITableViewDelegate,UITableViewDataSource,SearchKeywordViewDelegate>
@property(nonatomic,strong) SearchKeywordView *searchKeywordView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UITextField *searchTextField;

@property(nonatomic,strong) SearchViewModel *searchViewModel;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self initDataNotify];
    [self initNavigationBar];
    [self initTableView];
    [self initSearchKeywordView];
    [self initData];
}

- (void)initNavigationBar{
    [UIBarHelper navigationBarBackgroundColor:kColorDarkGreen controller:self];
        
    //导航栏按钮
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_tab_home"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationLeftBarAction)];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_tab_home"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationRightBarAction)];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, [UIBarHelper navigationBarHeight]-10)];
    _searchTextField.font = kFontText14;
    _searchTextField.backgroundColor = UIColorFromRGBWithAlpha(0x838383,0.50f);
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.placeholder = L(@"search_hint");
    [_searchTextField zt_cornerWithCornerRadii:100];
    
    self.navigationItem.titleView = _searchTextField;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}


- (void)navigationLeftBarAction{
    if(_searchViewModel.showSearchView){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        _searchViewModel.showSearchView = YES;
//        _searchViewModel.artcleArray = nil;//清空数据
    }
}

- (void)navigationRightBarAction{
    NSString *keyword = _searchTextField.text;
    if(keyword){
        //请求数据
        _searchViewModel.showSearchView = NO;
        [_searchViewModel getArticleList:keyword];
        
        //保存/更新本地数据
        SearchKeywordData *data = [[SearchKeywordData alloc] init];
        data.value = keyword;
        [_searchViewModel insertOrUpdateSearchKeyword:data];
    }
}


- (void)initDataNotify{
    _searchViewModel = [[SearchViewModel alloc] init];
    MJWeakSelf
    [self observe:_searchViewModel notify:^(SearchViewModel* observable, NSString * keyPath) {
        
        [weakSelf updateContentView:observable.showSearchView];
        NSLog(@"----keypath:%@",keyPath);
        if([keyPath isEqualToString:@"hotKeywordArray"]){
            [weakSelf updateHotKeyword:observable.hotKeywordArray];
        }else if([keyPath isEqualToString:@"historyKeywordArray"]){
            [weakSelf updateHistoryKeyword:observable.historyKeywordArray];
        }else if([keyPath isEqualToString:@"artcleArray"]){
            [weakSelf updateArticleTableView];
        }
        
    }];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;//自动计算高度
    _tableView.estimatedRowHeight = 50;//估算高度
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
}

- (void)initSearchKeywordView{
    _searchKeywordView = [[SearchKeywordView alloc] init];
    _searchKeywordView.childViewDelegate = self;
    [self.view addSubview:_searchKeywordView];
    [_searchKeywordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
}

- (void)initData{
    [_searchViewModel getHotKeyword];
    [_searchViewModel getHistoryKeyword];
}

#pragma mark -更新UI
- (void)updateHotKeyword:(NSArray*)keywordArray{
    [_searchKeywordView setHotKeywordArray:keywordArray];
}

- (void)updateHistoryKeyword:(NSArray*)keywordArray{
    NSLog(@"----keywordArray:%@",keywordArray);
    [_searchKeywordView setHistoryKeywordArray:keywordArray];
}

- (void)updateArticleTableView{
    _searchKeywordView.hidden = YES;
    _tableView.hidden = NO;
    [_tableView reloadData];
}

- (void)updateContentView:(BOOL)showSearchView{
    _searchKeywordView.hidden = !showSearchView;
    _tableView.hidden = showSearchView;
}


#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"SearchArticleCell";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[ArticleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.data = [_searchViewModel.artcleArray objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchViewModel.artcleArray.count;
}


#pragma mark - SearchKeywordViewDelegate
- (void)searchKeywordView:(SearchKeywordView *)searchKeywordView editButtonClickEvent:(UIButton *)button{
    
}

- (void)searchKeywordView:(SearchKeywordView *)searchKeywordView tagViewDidSelected:(ZTUITagView *)tagView index:(NSInteger)index{
    
    _searchViewModel.showSearchView = NO;

    [_searchViewModel getArticleList:tagView.dataArray[index]];
    
    if(tagView == _searchKeywordView.historyContentTagView){
        SearchKeywordData *data = _searchViewModel.historySearchKeywordDataArray[index];
        [_searchViewModel deleteSearchKeyword:data.kid];
    }
}


@end
