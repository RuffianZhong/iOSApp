//
//  SearchDao.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import "SearchDao.h"

@implementation SearchDao
///搜索表
 static const NSString* tbSearch = @"tb_search";

 ///搜索ID
 static const NSString* fSearchId = @"f_search_id";

 ///搜索值
 static const NSString* fSearchValue = @"f_search_value";

 ///搜索时间
 static const NSString* fSearchTime = @"f_search_time";


+ (NSString *)createTableSQL{
    ///创建搜索表
    NSString* sqlTemp = @"create table IF NOT EXISTS %@ (%@ integer primary key autoincrement,%@ text not null,%@ integer not null)";
    NSString* sql = [NSString stringWithFormat:sqlTemp,tbSearch,fSearchId,fSearchValue,fSearchTime];
    return sql;
}

- (void)insertOrUpdate:(SearchKeywordData *)searchKeywordData result:(void (^)(BOOL))result{
    NSString *sql = nil;
    NSArray* valueArray = nil;
    NSInteger kid = searchKeywordData.kid;
    searchKeywordData.time = [NSDate date].timeIntervalSince1970;//当前时间
    
    if(kid <=0 ){
        
        sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@) VALUES (?, ?);", tbSearch,fSearchValue,fSearchTime];
        
        valueArray = @[
            searchKeywordData.value,
            [NSNumber numberWithInteger:searchKeywordData.time]
        ];
        
    }else{
        
        sql = [NSString stringWithFormat:@"update %@ set %@ = ?, %@ = ? where %@ = ?;", tbSearch,fSearchValue,fSearchTime,fSearchId];
        
        valueArray = @[
            searchKeywordData.value,
            [NSNumber numberWithInteger:searchKeywordData.time],
            [NSNumber numberWithInteger:searchKeywordData.kid]
        ];
    }
    
    [self.dbHelper updateWithSQL:sql arguments:valueArray result:^(BOOL resultBOOL) {
        NSLog(@"--insert:%@----",result?@"Y":@"No");
        if(result) result(resultBOOL);
    }];
}

- (void)querySearchKeywordArray:(void (^)(NSMutableArray<SearchKeywordData *> * _Nonnull))result{
    NSString *sql = [NSString stringWithFormat:@"select * FROM %@;", tbSearch];

    [self.dbHelper queryWithSQL:sql arguments:[NSMutableArray array] result:^(FMResultSet * _Nonnull resultSet) {
        
        NSMutableArray<SearchKeywordData*> *dataArray = [NSMutableArray array];
        SearchKeywordData *data;
         // 2.遍历结果
         while ([resultSet next]) {
             data = [[SearchKeywordData alloc] init];
             data.kid = [resultSet intForColumn:fSearchId];
             data.value = [resultSet stringForColumn:fSearchValue];
             data.time = [resultSet intForColumn:fSearchTime];
             [dataArray addObject:data];
         }
        NSLog(@"--querySearchKeywordArray:%@----",dataArray);

        if(result) result(dataArray);

    }];
}

- (void)deleteSearchKeyword:(NSInteger)keywordId result:(void (^)(BOOL))result{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ where %@ = ?;", tbSearch,fSearchId];
    NSArray* valueArray = @[[NSNumber numberWithInteger:keywordId]];
    
    [self.dbHelper updateWithSQL:sql arguments:valueArray result:^(BOOL resultBOOL) {
        if(result) result(resultBOOL);
    }];
}


@end
