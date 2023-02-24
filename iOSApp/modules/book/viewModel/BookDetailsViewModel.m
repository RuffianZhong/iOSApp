//
//  BookDetailsViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import "BookDetailsViewModel.h"

@implementation BookDetailsViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;

    _bookModel = [[BookModel alloc]init];
    _dataArray = [NSMutableArray array];
    _studyDao = [[StudyDao alloc] init];
    return self;
}

//获取教程列表
-(void)getBookArticleList:(NSInteger)categoryId bookId:(NSInteger)bookId{
    [_bookModel getBookArticleList:categoryId onSuccess:^(NSMutableArray<ArticleData *> * _Nonnull response) {
        self.dataArray = response;
        
        [self queryWithBookId:bookId];
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        
    }];
}

//插入/更新学习进度
- (void)insertOrUpdate:(StudyData*)studyData{
    [_studyDao insertOrUpdate:studyData result:^(BOOL resultBOOL) {
        if(resultBOOL){
            //更新列表数据
            [self updateStudyData:studyData];
        }
    }];
}

//查询某教程所有学习进度
- (void)queryWithBookId:(NSInteger)bookId{
    WeakSelf
    [_studyDao queryWithId:bookId result:^(NSMutableArray<StudyData *> * _Nonnull dataArray) {
        
        StudyData *studyData = nil;
        ArticleData *articleData = nil;
        NSMutableArray<ArticleData*> *tempArray = weakSelf.dataArray;
        //匹配本地学习数据
        for (int i = 0; i < tempArray.count; i++) {
            articleData = [tempArray objectAtIndex:i];
            
            for (int j = 0; j < dataArray.count; j++) {
                studyData = [dataArray objectAtIndex:j];
                
                if(studyData.articleId == articleData.aid){
                    articleData.studyData = studyData;
                    break;
                }
            }
            
            tempArray[i] = articleData;
        }
        
        weakSelf.dataArray = tempArray;
    }];
}

- (void)updateStudyData:(StudyData*) studyData{
    
    ArticleData *articleData = nil;
    NSMutableArray<ArticleData*> *tempArray = [self.dataArray mutableCopy];
    //匹配本地学习数据
    for (int i = 0; i < tempArray.count; i++) {
        articleData = [tempArray objectAtIndex:i];
        
        if(studyData.articleId == articleData.aid){
            articleData.studyData = studyData;
            break;
        }
        
        tempArray[i] = articleData;
    }
    self.dataArray = tempArray;
}


@end
