//
//  DBHelper.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/3.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBHelper : NSObject

+ (instancetype)shareHelper;

#pragma mark -FMDatabaseQueue

/// 插入数据
/// @param sql sql语句
/// @param arguments 参数
- (void)insertWithSQL:(NSString*)sql arguments:(NSArray *)arguments result:(void (^)(NSInteger resultId))result;

/// 更新数据（除了查询）
/// @param sql sql语句
/// @param arguments 参数
- (void)updateWithSQL:(NSString*)sql arguments:(NSArray *)arguments result:(void (^)(BOOL result))result;

/// 查询数据
/// @param sql sql语句
/// @param arguments 参数
- (void)queryWithSQL:(NSString*)sql arguments:(NSArray *)arguments result:(void (^)(FMResultSet * resultSet))result;

@end

NS_ASSUME_NONNULL_END
