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
    
    _searchModel = [[SearchModel alloc]init];
    _artcleArray = [NSMutableArray array];
    _hotKeywordArray = [NSMutableArray array];
    _searchDao = [[SearchDao alloc] init];
    _historySearchKeywordDataArray = [NSMutableArray array];
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

- (void)getHistoryKeyword{
    [_searchDao querySearchKeywordArray:^(NSMutableArray<SearchKeywordData *> * _Nonnull dataArray) {
        if(dataArray==nil ||dataArray.count==0) return;
        
        NSMutableArray<NSString*> *keywordArray = [NSMutableArray array];
        NSString *value = nil;
        for (int i = 0; i < dataArray.count; i++) {
            value = dataArray[i].value;
            [keywordArray addObject:value];
        }
        NSLog(@"-----%@",keywordArray);
        self.historyKeywordArray = keywordArray;
        self->_historySearchKeywordDataArray = dataArray;
    }];
}

- (void)insertOrUpdateSearchKeyword:(SearchKeywordData *)data{
    [_searchDao insertOrUpdate:data result:^(BOOL result) {
        
    }];
}

- (void)deleteSearchKeyword:(NSInteger)keywordId{
    [_searchDao deleteSearchKeyword:keywordId result:^(BOOL result) {
        if(result){
            SearchKeywordData *data = nil;
            NSString *value = nil;
            NSMutableArray *tempArray = self->_historySearchKeywordDataArray;
            for (int i = 0; i < tempArray.count; i++) {
                data = tempArray[i];
                if(data.kid == keywordId){
                    [tempArray removeObjectAtIndex:i];
                    value = data.value;
                    break;
                }
            }
            self->_historySearchKeywordDataArray = tempArray;
            
            //删除某个数据再重新赋值
            [self.historyKeywordArray removeObject:value];
            self.historyKeywordArray = self.historyKeywordArray;

        }
    }];
}

@end
