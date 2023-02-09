//
//  CollectViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import <Foundation/Foundation.h>
#import "CollectModel.h"
#import "ArticleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectViewModel : NSObject

@property(nonatomic,strong) CollectModel *collectModel;

@property(nonatomic,strong) NSMutableArray<ArticleData*> *artcleArray;
@property(nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,assign) NSInteger refreshState; //刷新状态：0:没有刷新 1:下啦刷新 2:上来加载

/// 加载数据
/// @param refresh 是否下拉刷新
- (void)getArtcleListWithRefresh:(BOOL)refresh;
@end

NS_ASSUME_NONNULL_END
