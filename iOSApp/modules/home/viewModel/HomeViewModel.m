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
    
    _homeModel = [[HomeModel alloc] init];
    _collectModel = [[CollectModel alloc] init];
    _artcleArray = [NSMutableArray array];
    
    return self;
}

/// 加载数据
/// @param refresh 是否下拉刷新
- (void)getArtcleListWithRefresh:(BOOL)refresh{
    
    _refreshState = 0;
    if(refresh) _pageIndex = 0;
    [_homeModel getArticleList:_pageIndex onSuccess:^(NSMutableArray<ArticleData *> * _Nonnull response) {
       
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


/// 加载置顶数据
- (void)getTopArtcleList{
    [_homeModel getArticleTopListOnSuccess:^(NSMutableArray<ArticleData *> * _Nonnull response) {
        self.topArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        self.topArray = [NSMutableArray array];
    }];
}

/// 加载内容数据
- (void)getContentArtcleList:(BOOL)refresh{
    _refreshState = 0;
    if(refresh) _pageIndex = 0;
    [_homeModel getArticleList:_pageIndex onSuccess:^(NSMutableArray<ArticleData *> * _Nonnull response) {
       
        if(refresh){
            //直接覆盖更新
            self.contentArray = response;
        }else{
            [self.contentArray addObjectsFromArray:response];
            //通过 mutableArrayValueForKey 添加更新
//            [[self mutableArrayValueForKey:@"artcleArray"] addObjectsFromArray:response];
        }
        self->_pageIndex++;
//        self.refreshState = refresh ? 1 : 2;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
//        self.refreshState = refresh ? 1 : 2;
    }];
}

/// 加载数据
/// @param refresh 是否下拉刷新
- (void)getArtcleListWithRefresh2:(BOOL)refresh{
    
    //队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //队列组
    dispatch_group_t group =  dispatch_group_create();

    dispatch_group_async(group, queue, ^{
        [self getTopArtcleList];
        NSLog(@"---------队列组耗时任务 1:%@",self.topArray);

    });

    dispatch_group_async(group, queue, ^{
        [self getContentArtcleList:refresh];
        NSLog(@"---------队列组耗时任务 2");
    });

    //组内异步任务都已经完成
    dispatch_group_notify(group, queue, ^{
        NSLog(@"-------通知：队列组中耗时任务都已经完成了:%@",[NSThread isMainThread]?@"YES":@"NO");
        
//        self.refreshState = refresh ? 1 : 2;
//        NSMutableArray *array = [NSMutableArray array];
//        [array addObjectsFromArray:self.topArray];
//        [array addObjectsFromArray:self.contentArray];
//        self.artcleArray = array;

        [self performSelectorOnMainThread:@selector(updateDataOnMainThread:) withObject:refresh?@"YES":@"NO" waitUntilDone:NO];
    });
}

- (void)updateDataOnMainThread:(NSString*)obj{
    
    BOOL refresh = [obj isEqualToString:@"YES"];
        self.refreshState = refresh ? 1 : 2;
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:self.topArray];
        [array addObjectsFromArray:self.contentArray];
        self.artcleArray = array;
    
}

- (void)getBannerList{
    [_homeModel getBannerListOnSuccess:^(NSMutableArray<BannerData *> * _Nonnull response) {
        self.bannerArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
    }];
}

- (void)collectOrCancelArticle:(NSInteger)articleId collect:(BOOL)collect{
    [_collectModel collectOrCancelArticle:articleId collect:collect onSuccess:^{
        NSMutableArray *tempArray = [self.artcleArray mutableCopy];
        ArticleData *tempData;
        for (int i=0; i<tempArray.count; i++) {
            tempData = tempArray[i];
            if(tempData.aid == articleId){
                tempData.collect = !tempData.collect;
                tempArray[i] = tempData;
                break;
            }
        }
        self.artcleArray = tempArray;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        
    }];
}

@end
