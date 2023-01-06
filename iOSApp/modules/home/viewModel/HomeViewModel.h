//
//  HomeViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/4.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"
#import "ArtcleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject

@property(nonatomic,strong) HomeModel *homeModel;

@property(nonatomic,strong) NSMutableArray<ArtcleData*> *artcleArray;
@property(nonatomic,strong) NSMutableArray<BannerData*> *bannerArray;

@property(nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,assign) NSInteger refreshState; //刷新状态：0:没有刷新 1:下啦刷新 2:上来加载


/// 加载数据
/// @param refresh 是否下拉刷新
- (void)getArtcleListWithRefresh:(BOOL)refresh;

- (void)getBannerList;

@end

NS_ASSUME_NONNULL_END
