//
//  SearchViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import "SearchViewModel.h"

@implementation SearchViewModel


- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _searchDao = [[SearchDao alloc] init];
    _searchModel = [[SearchModel alloc] init];
    _artcleArray = [NSMutableArray array];
    _hotKeywordArray = [NSMutableArray array];
    _historyKeywordArray = [NSMutableArray array];
    _searchKeywordDataArray = [NSMutableArray array];
    _showSearchView = YES;
    
    return self;
}

- (void)getHotKeyword{
    [_searchModel getHotKeywordOnSuccess:^(NSMutableArray<NSString *> * _Nonnull response) {
        self.hotKeywordArray = response;
        } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
            
        }];
}

- (void)getArticleList:(NSString*)keyword{
    [_searchModel getArticleList:keyword onSuccess:^(NSMutableArray<ArticleData *> * _Nonnull response) {
        self.artcleArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        
    }];
}

//获取搜索数据：已存在更新数据，不存在则新建实例
- (SearchKeywordData*)getSearchKeywordDataWithKeyword:(NSString*)keyword{
    SearchKeywordData *data = nil;
    SearchKeywordData *targetData = nil;

    if(keyword && _searchKeywordDataArray){
        for (int i=0; i<_searchKeywordDataArray.count; i++) {
            data = [_searchKeywordDataArray objectAtIndex:i];
            if([data.value isEqualToString:keyword]){
                targetData = data;
                break;
            }
        }
    }
    if(!targetData){
        targetData = [[SearchKeywordData alloc] init];
        targetData.value = keyword;
    }
    return targetData;
}

- (void)getHistoryKeyword{
    [_searchDao querySearchKeywordArray:^(NSMutableArray<SearchKeywordData *> * _Nonnull dataArray) {
        if(dataArray==nil ||dataArray.count==0) return;
        
        NSMutableArray<NSString*> *keywordArray = [NSMutableArray array];
        NSString *value = nil;
        for (int i = 0; i < dataArray.count; i++) {
            value = dataArray[i].value;
            [keywordArray addObject:value];
        }
        self.historyKeywordArray = keywordArray;
        self->_searchKeywordDataArray = dataArray;
    }];
}

- (void)insertOrUpdateSearchKeyword:(SearchKeywordData *)data{
    [_searchDao insertOrUpdate:data result:^(SearchKeywordData *resultData) {
        if(resultData){
            
            NSMutableArray<SearchKeywordData*> *tempArray = [self.searchKeywordDataArray mutableCopy];
            NSMutableArray<NSString*> *tempArrayString = [self.historyKeywordArray mutableCopy];
            
            [tempArray removeObject:data];
            [tempArray insertObject:data atIndex:0];
            [tempArrayString removeObject:data.value];
            [tempArrayString insertObject:data.value atIndex:0];
            
            self.historyKeywordArray = tempArrayString;
            self.searchKeywordDataArray = tempArray;
        }
    }];
}

- (void)deleteSearchKeyword:(NSInteger)keywordId{
    [_searchDao deleteSearchKeyword:keywordId result:^(BOOL result) {
        if(result){
            SearchKeywordData *data = nil;
            NSMutableArray *tempArray = [self->_searchKeywordDataArray mutableCopy];
            NSMutableArray<NSString*> *tempArrayString = [self->_historyKeywordArray mutableCopy];
            for (int i = 0; i < tempArray.count; i++) {
                data = tempArray[i];
                if(data.kid == keywordId){
                    [tempArray removeObjectAtIndex:i];
                    [tempArrayString removeObjectAtIndex:i];
                    break;
                }
            }

            self.historyKeywordArray = tempArrayString;
            self->_searchKeywordDataArray = tempArray;
        }
    }];
}

@end
