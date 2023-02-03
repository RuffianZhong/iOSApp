//
//  StudyDao.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/3.
//

#import "StudyDao.h"

@implementation StudyDao

  ///表
  static const NSString* tbBookStudy = @"tb_book_study";

  ///表ID
  static const NSString* fBookStudyId = @"f_book_study_id";

  ///教程ID
  static const NSString* fBookId = @"f_book_id";

  ///文章ID：章节ID
  static const NSString* fArticleId = @"f_article_id";

  ///学习进度
  static const NSString* fStudyProgress = @"f_study_progress";

  ///学习时间
  static const NSString* fStudyTime = @"f_study_time";


///创建表SQL
+ (NSString*)createTableSQL{
    ///创建搜索表
    NSString* sqlTemp = @"create table IF NOT EXISTS %@ (%@ integer primary key autoincrement,%@ integer not null,%@ integer not null,%@ real not null,%@ integer not null)";
    NSString* sql = [NSString stringWithFormat:sqlTemp,tbBookStudy,fBookStudyId,fBookId,fArticleId,fStudyProgress,fStudyTime];
    return sql;
}

/// 插入数据或者更新数据
/// id不存在：插入数据；id存在：更新数据
- (void)insertOrUpdate:(StudyData*)studyData result:(void (^)(BOOL result))result{
    NSString *sql = nil;
    NSArray* valueArray = nil;
    NSInteger sid = studyData.sid;
    studyData.time = [NSDate date].timeIntervalSince1970;//当前时间
    
    if(sid <=0 ){
        
        sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@, %@) VALUES (?, ?, ?, ?);", tbBookStudy,fBookId,fArticleId,fStudyProgress,fStudyTime];
        
        valueArray = @[
            [NSNumber numberWithInteger:studyData.bookId],
            [NSNumber numberWithInteger:studyData.articleId],
            [NSNumber numberWithFloat:studyData.progress],
            [NSNumber numberWithInteger:studyData.time]];
        
    }else{
        
        sql = [NSString stringWithFormat:@"update %@ set %@ = ?, %@ = ?, %@ = ?, %@ = ? where %@ = ?;", tbBookStudy,fBookId,fArticleId,fStudyProgress,fStudyTime,fBookStudyId];
        
        valueArray = @[
            [NSNumber numberWithInteger:studyData.bookId],
            [NSNumber numberWithInteger:studyData.articleId],
            [NSNumber numberWithFloat:studyData.progress],
            [NSNumber numberWithInteger:studyData.time],
            [NSNumber numberWithInteger:studyData.sid]
        ];
    }
    
    [self.dbHelper updateWithSQL:sql arguments:valueArray result:^(BOOL resultBOOL) {
        if(result) result(resultBOOL);
    }];
}

//删除数据
- (void)delete:(NSInteger)studyId result:(void (^)(BOOL result))result{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ where %@ = ?;", tbBookStudy,fBookStudyId];
    NSArray* valueArray = @[[NSNumber numberWithInteger:studyId]];
    
    [self.dbHelper updateWithSQL:sql arguments:valueArray result:^(BOOL resultBOOL) {
        if(result) result(resultBOOL);
    }];
}

//查询数据
- (void)queryWithId:(NSInteger)bookId result:(void (^)(NSMutableArray<StudyData*> *dataArray))result{
    NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where %@ = ?;", tbBookStudy,fBookId];
    NSArray* valueArray = @[[NSNumber numberWithInteger:bookId]];

    [self.dbHelper queryWithSQL:sql arguments:valueArray result:^(FMResultSet * _Nonnull resultSet) {
        
        NSMutableArray<StudyData*> *dataArray = [NSMutableArray array];
        StudyData *data;
         // 2.遍历结果
         while ([resultSet next]) {
             data = [[StudyData alloc] init];
             data.sid = [resultSet intForColumn:fBookStudyId];
             data.bookId = [resultSet intForColumn:fBookId];
             data.progress = [resultSet doubleForColumn:fStudyProgress];
             data.time = [resultSet intForColumn:fStudyTime];
             data.articleId = [resultSet intForColumn:fArticleId];
             [dataArray addObject:data];
         }
        
        if(result) result(dataArray);

    }];
}

@end
