//
//  StudyDao.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/3.
//

#import "BaseDao.h"
#import "StudyData.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudyDao : BaseDao

///创建表SQL
+ (NSString*)createTableSQL;

/// 插入数据或者更新数据
/// id不存在：插入数据；id存在：更新数据
- (void)insertOrUpdate:(StudyData*)studyData result:(void (^)(BOOL result))result;

//删除数据
- (void)delete:(NSInteger)studyId result:(void (^)(BOOL result))result;

//查询数据
- (void)queryWithId:(NSInteger)bookId result:(void (^)(NSMutableArray<StudyData*> *dataArray))result;

@end

NS_ASSUME_NONNULL_END
