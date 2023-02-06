//
//  SearchModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import "SearchModel.h"
#import "ImageHelper.h"

@implementation SearchModel


-(void)getHotKeywordOnSuccess:(void (^)(NSMutableArray<NSString*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"/hotkey/json";
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSMutableArray<SearchKeywordData*> *dataArray = [SearchKeywordData mj_objectArrayWithKeyValuesArray:response];
        
        NSMutableArray<NSString*> *array = [NSMutableArray array];
        for (int i=0; i<dataArray.count; i++) {
            [array addObject:dataArray[i].value];
        }
        
        success(array);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}


-(void)getArticleList:(NSString*)keyword
            onSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"/article/query/0/json";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"k"] = keyword;
    
    [[ZTHttpManager shareManager] post:api parameters:parameters parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
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
