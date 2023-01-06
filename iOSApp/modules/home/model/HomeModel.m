//
//  HomeModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/4.
//

#import "HomeModel.h"
#import "ArtcleData.h"
#import "BannerData.h"

@implementation HomeModel

-(void)getArticleList:(NSInteger)pageIndex
            onSuccess:(void (^)(NSMutableArray<ArtcleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = [NSString stringWithFormat:@"article/list/%ld/json", pageIndex];
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSArray *array = [response objectForKey:@"datas"];
        NSMutableArray<ArtcleData*> *dataArray = [ArtcleData mj_objectArrayWithKeyValuesArray:array];
        
        ArtcleData *data;
        for (int i = 0; i < dataArray.count; i++) {
            data = dataArray[i];
            data.userIcon = [self randomUrl];
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

-(void)getArticleTopListOnSuccess:(void (^)(NSMutableArray<ArtcleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"article/top/json";
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        NSMutableArray<ArtcleData*> *dataArray = [ArtcleData mj_objectArrayWithKeyValuesArray:response];
        
        ArtcleData *data;
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


- (NSString *)randomUrl{
    
    NSArray *array = @[
        @"https://img2.baidu.com/it/u=1994380678,3283034272&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1657213200&t=d57830e0ca280cc0f87fdbf10b25305b",
        @"https://img2.baidu.com/it/u=2860188096,638334621&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1657213200&t=cc435e450717a2beb0623dd45752f75f",
        @"https://img1.baidu.com/it/u=592570905,1313515675&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1657213200&t=1d3fe5d6db1996aa3b45c8636347869d",
        @"https://img2.baidu.com/it/u=4244269751,4000533845&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1657213200&t=9e3bbec87e572ee9bf269a018c71e0ac",
        @"https://img1.baidu.com/it/u=2029513305,2137933177&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1657213200&t=fc9d00fc14a8feeb19be958ba428ecba",
        @"https://img0.baidu.com/it/u=1694074520,2517635995&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1657472400&t=3b8cee3f0f6a844e69f3b43dff3d8465"
    ];
    
    int random = arc4random() % 5;
    return array[random];
}

@end
