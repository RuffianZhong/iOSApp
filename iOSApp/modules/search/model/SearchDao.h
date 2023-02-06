//
//  SearchDao.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import "BaseDao.h"
#import "SearchKeywordData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchDao : BaseDao

///创建表SQL
+ (NSString*)createTableSQL;

/// 插入数据或者更新数据
/// id不存在：插入数据；id存在：更新数据
- (void)insertOrUpdate:(SearchKeywordData*)searchKeywordData result:(void (^)(BOOL result))result;

//删除数据
- (void)deleteSearchKeyword:(NSInteger)keywordId result:(void (^)(BOOL result))result;

//查询数据
- (void)querySearchKeywordArray:(void (^)(NSMutableArray<SearchKeywordData*> *dataArray))result;
@end

NS_ASSUME_NONNULL_END
