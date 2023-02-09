//
//  CollectViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import "CollectViewModel.h"

@implementation CollectViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _collectModel = [[CollectModel alloc] init];
    _artcleArray = [NSMutableArray array];
    
    return self;
}

/// 加载数据
/// @param refresh 是否下拉刷新
- (void)getArtcleListWithRefresh:(BOOL)refresh{
    
    _refreshState = 0;
    if(refresh) _pageIndex = 0;
    [_collectModel getArticleList:_pageIndex onSuccess:^(NSMutableArray<ArticleData *> * _Nonnull response) {
       
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

@end
