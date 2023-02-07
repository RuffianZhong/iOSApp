//
//  DBHelper.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/3.
//

#import "DBHelper.h"
#import "StudyDao.h"
#import "SearchDao.h"

@interface DBHelper()
@property(nonatomic,strong) FMDatabaseQueue *dbQueue;
@property(nonatomic,strong) NSString *dbName;
@end


@implementation DBHelper

#pragma mark -单例
static id _instance;

+ (instancetype)shareHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self == [super init]) {
            //加载所需资源
            [self initFMDatabaseQueue];
       }
    });
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark -FMDatabaseQueue
- (void)initFMDatabaseQueue{
    if(!_dbQueue){
        _dbName = @"ZTiOSApp.sqlite";
        //获取数据库文件的路径
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [docPath stringByAppendingPathComponent:_dbName];

        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
        //创建表
        [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            [db open];
            //创建表
            [db executeUpdate:[StudyDao createTableSQL]];
            [db executeUpdate:[SearchDao createTableSQL]];
            
            [db close];
        }];
    }
}

/// 插入数据
/// @param sql sql语句
/// @param arguments 参数
- (void)insertWithSQL:(NSString*)sql arguments:(NSArray *)arguments result:(void (^)(NSInteger resultId))result{
    //[db executeUpdate:@"INSERT INTO foo VALUES (?, ? , ?)" withArgumentsInArray:@[@1, @"zt", @30]];
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        BOOL success = [db executeUpdate:sql withArgumentsInArray:arguments];
        NSInteger _id = success ? db.lastInsertRowId : -1;
        if(result) result(_id);
        [db close];
    }];
}

/// 更新数据（除了查询）
/// @param sql sql语句
/// @param arguments 参数
- (void)updateWithSQL:(NSString*)sql arguments:(NSArray *)arguments result:(void (^)(BOOL result))result{
    //[db executeUpdate:@"INSERT INTO foo VALUES (?, ? , ?)" withArgumentsInArray:@[@1, @"zt", @30]];
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        BOOL success = [db executeUpdate:sql withArgumentsInArray:arguments];
        if(result) result(success);
        [db close];
    }];
}

/// 查询数据
/// @param sql sql语句
/// @param arguments 参数
- (void)queryWithSQL:(NSString*)sql arguments:(NSArray *)arguments result:(void (^)(FMResultSet * resultSet))result{
    //FMResultSet *rs = [db executeQuery:@"select * from foo"];
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        FMResultSet * resultSet = [db executeQuery:sql withArgumentsInArray:arguments];
        if(result) result(resultSet);
        [db close];
    }];
}

@end
