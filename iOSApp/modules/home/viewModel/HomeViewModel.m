//
//  HomeViewModel.m
//  iOSApp
//
//  备注：
//      KVO 属性更新 实现 MVVM
//
//      触发 KVO 属性更新的方式：
//      self.refreshState = 0
//      [[self mutableArrayValueForKey:@"artcleArray"] addObjectsFromArray:response];
//
//      不会触发 KVO 属性更新的方式：
//      _refreshState = 0; 不会触发 MVVM 属性更新
//
//  Created by 钟达烽 on 2023/1/4.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _homeModel = [[HomeModel alloc]init];
    _artcleArray = [NSMutableArray array];
    
    return self;
}

/// 加载数据
/// @param refresh 是否下拉刷新
- (void)getArtcleListWithRefresh:(BOOL)refresh{
    
    _refreshState = 0;
    if(refresh) _pageIndex = 0;
    [_homeModel getArticleList:_pageIndex onSuccess:^(NSMutableArray<ArtcleData *> * _Nonnull response) {
       
        if(refresh){
            //直接覆盖更新
            self.artcleArray = response;
        }else{
            //通过 mutableArrayValueForKey 添加更新
            [[self mutableArrayValueForKey:@"artcleArray"] addObjectsFromArray:response];
        }
        self->_pageIndex++;
        self.refreshState = refresh ? 1 : 2;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        self.refreshState = refresh ? 1 : 2;
    }];
}

- (void)getBannerList{
    [_homeModel getBannerListOnSuccess:^(NSMutableArray<BannerData *> * _Nonnull response) {
        self.bannerArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
    }];
}

@end
