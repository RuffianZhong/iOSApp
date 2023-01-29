//
//  HomeModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/4.
//

#import "HomeModel.h"
#import "ArticleData.h"
#import "BannerData.h"
#import "ImageHelper.h"

@implementation HomeModel

-(void)getArticleList:(NSInteger)pageIndex
            onSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = [NSString stringWithFormat:@"article/list/%ld/json", pageIndex];
    
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

-(void)getArticleTopListOnSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"article/top/json";
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSMutableArray<ArticleData*> *dataArray = [ArticleData mj_objectArrayWithKeyValuesArray:response];
        
        ArticleData *data;
        for (int i = 0; i < dataArray.count; i++) {
            data = dataArray[i];
            data.isTop = YES;
            dataArray[i] = data;
        }
        
        success(dataArray);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}


-(void)getBannerListOnSuccess:(void (^)(NSMutableArray<BannerData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"banner/json";
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSMutableArray<BannerData*> *dataArray = [BannerData mj_objectArrayWithKeyValuesArray:response];

        success(dataArray);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}

@end
