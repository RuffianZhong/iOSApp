//
//  KnowledgeViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import "KnowledgeViewModel.h"

@implementation KnowledgeViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _knowledgeModel = [[KnowledgeModel alloc]init];
    _knowledgeData = [[KnowledgeData alloc] init];
    return self;
}

///获取分类列表
- (void)getCategoryList {
    [_knowledgeModel getSystemListOnSuccess:^(NSMutableArray<CategoryData *> * _Nonnull response) {
        self->_knowledgeData.categoryArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        
    }];
}

///获取导航列表
- (void)getNavList {
    [_knowledgeModel getNavListOnSuccess:^(NSMutableArray<NavData *> * _Nonnull response) {
        self->_knowledgeData.navArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        
    }];
}

///获取列表标题
- (NSString*)titleForIndex:(NSInteger)index withType:(NSInteger)type{
    NSString *title = nil;
    if(type == 0){
        title = _knowledgeData.categoryArray[index].name;
    }else{
        title = _knowledgeData.navArray[index].name;
    }
    return title;
}

///获取列表标签
- (NSArray<NSString*>*)tagArrayForIndex:(NSInteger)index withType:(NSInteger)type{
    NSMutableArray<NSString*>* array= [NSMutableArray array];
    if(type == 0){
        for(int i = 0;i < _knowledgeData.categoryArray[index].childArray.count; i++){
            [array addObject:_knowledgeData.categoryArray[index].childArray[i].name];
        }
    }else{
        for(int i = 0;i < _knowledgeData.navArray[index].articleArray.count; i++){
            [array addObject:_knowledgeData.navArray[index].articleArray[i].title];
        }
    }
    return array;
}


@end
