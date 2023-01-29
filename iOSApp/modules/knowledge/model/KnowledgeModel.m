//
//  KnowledgeModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import "KnowledgeModel.h"

@implementation KnowledgeModel

///获取体系分类列表
-(void)getSystemListOnSuccess:(void (^)(NSMutableArray<CategoryData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"tree/json";
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSMutableArray<CategoryData*> *dataArray = [CategoryData mj_objectArrayWithKeyValuesArray:response];
        
        success(dataArray);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}

///获取导航分类列表
-(void)getNavListOnSuccess:(void (^)(NSMutableArray<NavData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"navi/json";
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSMutableArray<NavData*> *dataArray = [NavData mj_objectArrayWithKeyValuesArray:response];
        
        success(dataArray);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}

///获取项目文章列表
///projectId：项目分类ID
-(void)getArticleList:(NSInteger)pageIndex categoryId:(NSInteger)categoryId
            onSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
   
    NSString *api = [NSString stringWithFormat:@"article/list/%li/json?cid=%li", pageIndex,categoryId];
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSArray *array = [response objectForKey:@"datas"];
        NSMutableArray<ArticleData*> *dataArray = [ArticleData mj_objectArrayWithKeyValuesArray:array];
        
        ArticleData *data;
        for (int i = 0; i < dataArray.count; i++) {
            data = dataArray[i];
            data.userIcon = [ImageHelper randomUrl];
            if(data.userName.length == 0 ){
                data.userName = [array[i] objectForKey:@"author"];
            }
            dataArray[i] = data;
        }
        
        success(dataArray);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}

@end
