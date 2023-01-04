//
//  HomeViewModel.m
//  iOSApp
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

- (void)getArtcleList{
    _finishRefresh = NO;
    [_homeModel getArticleList:_pageIndex onSuccess:^(NSMutableArray<ArtcleData *> * _Nonnull response) {
        self.artcleArray = response;
        self.finishRefresh = YES;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        self.finishRefresh = YES;
    }];
}

- (void)getBannerList{
    [_homeModel getBannerListOnSuccess:^(NSMutableArray<BannerData *> * _Nonnull response) {
        self.bannerArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
    }];
}

@end
