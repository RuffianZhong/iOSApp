//
//  BookController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "BookController.h"
#import "BookCollectionViewCell.h"
#import "BookViewModel.h"


@interface BookController ()<UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@property(nonatomic,strong) BookViewModel *bookViewModel;
@end

static NSString * const book_cell_id = @"book_cell_id";


@implementation BookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataNotify];
    [self initCollectionView];
    [self initData];
}

- (void)initCollectionView{
    
    CGFloat spacing = 15;
    CGFloat itemWidth = (self.view.frame.size.width - (spacing * 3)) / 2.0f;
    CGFloat itemHeight = itemWidth / 0.7f;

    _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionViewFlowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionViewFlowLayout.minimumLineSpacing = spacing;//行间距
    _collectionViewFlowLayout.minimumInteritemSpacing = spacing;//列间距
    _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:_collectionViewFlowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[BookCollectionViewCell class] forCellWithReuseIdentifier:book_cell_id];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(self.view);
    }];
}

- (void)initDataNotify{
    _bookViewModel = [[BookViewModel alloc] init];
    MJWeakSelf
    [self observe:_bookViewModel notify:^(BookViewModel *observable, NSString *keyPath) {
        [weakSelf.collectionView reloadData];
    }];
}

- (void)initData{
    [_bookViewModel getBookList];
}

#pragma mark - <UICollectionViewDataSource>
//列表数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _bookViewModel.bookArray.count;
}

//列表内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:book_cell_id forIndexPath:indexPath];
    BookData *data = [_bookViewModel.bookArray objectAtIndex:indexPath.row];
    [cell setData: data.cover];

    return cell;
}



@end
