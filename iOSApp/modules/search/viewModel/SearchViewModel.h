//
//  SearchViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"
#import "ArticleData.h"
#import "SearchDao.h"
#import "SearchKeywordData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewModel : NSObject

@property(nonatomic,strong) SearchModel *searchModel;
@property(nonatomic,strong) SearchDao *searchDao;

@property(nonatomic,strong) NSMutableArray<ArticleData*> *artcleArray;
@property(nonatomic,strong) NSMutableArray<NSString*> *hotKeywordArray;
@property(nonatomic,strong) NSMutableArray<NSString*> *historyKeywordArray;

@property(nonatomic,strong) NSMutableArray<SearchKeywordData*> *historySearchKeywordDataArray;

@property(nonatomic,assign) BOOL showSearchView;//展示搜索界面

- (void)getHotKeyword;

- (void)getArticleList:(NSString*)keyword;

- (void)getHistoryKeyword;

- (void)insertOrUpdateSearchKeyword:(SearchKeywordData *)data;

- (void)deleteSearchKeyword:(NSInteger)keywordId;
     
@end

NS_ASSUME_NONNULL_END
