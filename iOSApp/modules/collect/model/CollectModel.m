//
//  CollectModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import "CollectModel.h"
#import "ImageHelper.h"

@implementation CollectModel


-(void)getArticleList:(NSInteger)pageIndex
            onSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = [NSString stringWithFormat:@"lg/collect/list/%ld/json", pageIndex];
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSArray *array = [response objectForKey:@"datas"];
        NSMutableArray<ArticleData*> *dataArray = [ArticleData mj_objectArrayWithKeyValuesArray:array];
        
        ArticleData *data;
        for (int i = 0; i < dataArray.count; i++) {
            data = dataArray[i];
            data.collect = YES;//此属性恒为YES
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

- (void)collectOrCancelArticle:(NSInteger)articleId collect:(BOOL)collect onSuccess:(void(^)(void))success onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *apiUrl = collect ? @"lg/collect/%ld/json" :@"lg/uncollect_originId/%ld/json";
    
    NSString *api = [NSString stringWithFormat:apiUrl, articleId];
    
    [[ZTHttpManager shareManager] post:api parameters:[NSMutableDictionary dictionary] parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        success();
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}


@end
