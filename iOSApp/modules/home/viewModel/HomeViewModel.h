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
@property(nonatomic,assign) BOOL finishRefresh;//完成加载


- (void)getArtcleList;

- (void)getBannerList;

@end

NS_ASSUME_NONNULL_END
