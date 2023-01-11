//
//  ArtcleListViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import <Foundation/Foundation.h>
#import "ArtcleData.h"
#import "ProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtcleListViewModel : NSObject

@property(nonatomic,strong) ProjectModel *projectModel;


@property(nonatomic,strong) NSMutableArray<ArtcleData*> *artcleArray;

@property(nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,assign) NSInteger refreshState; //刷新状态：0:没有刷新 1:下啦刷新 2:上来加载


/// 加载数据
/// @param categoryId 分类ID
/// @param refresh 是否下拉刷新
- (void)getArtcleListWithCategoryId:(NSInteger)categoryId refresh:(BOOL)refresh;
@end

NS_ASSUME_NONNULL_END
