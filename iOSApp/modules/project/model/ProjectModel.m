//
//  ProjectModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import "ProjectModel.h"
#import "ImageHelper.h"


@implementation ProjectModel


-(void)getArticleList:(NSInteger)pageIndex categoryId:(NSInteger)categoryId
            onSuccess:(void (^)(NSMutableArray<ArtcleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = [NSString stringWithFormat:@"project/list/%li/json?cid=%li", pageIndex,categoryId];
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSArray *array = [response objectForKey:@"datas"];
        NSMutableArray<ArtcleData*> *dataArray = [ArtcleData mj_objectArrayWithKeyValuesArray:array];
        
        ArtcleData *data;
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

-(void)getCategoryListOnSuccess:(void (^)(NSMutableArray<CategoryData*> *response))success
                       onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"project/tree/json";
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSMutableArray<CategoryData*> *dataArray = [CategoryData mj_objectArrayWithKeyValuesArray:response];

        success(dataArray);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}
@end
