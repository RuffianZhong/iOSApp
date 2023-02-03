//
//  BookDetailsViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import <Foundation/Foundation.h>
#import "BookModel.h"
#import "ArticleData.h"
#import "StudyDao.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookDetailsViewModel : NSObject
@property(nonatomic,strong) BookModel *bookModel;
@property(nonatomic,strong) NSMutableArray<ArticleData*> *dataArray;
@property(nonatomic,strong) StudyDao *studyDao;

//获取教程列表
-(void)getBookArticleList:(NSInteger)categoryId bookId:(NSInteger)bookId;

//插入/更新学习进度
- (void)insertOrUpdate:(StudyData*)studyData;

@end

NS_ASSUME_NONNULL_END
