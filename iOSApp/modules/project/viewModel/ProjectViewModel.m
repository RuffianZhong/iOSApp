//
//  ProjectViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import "ProjectViewModel.h"

@implementation ProjectViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _projectModel = [[ProjectModel alloc]init];
    _categoryArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    
    return self;
}

- (void)getCategoryList{
    [_projectModel getCategoryListOnSuccess:^(NSMutableArray<CategoryData *> * _Nonnull response) {
        NSMutableArray *titleArray = [NSMutableArray array];
        for (int i = 0 ; i < response.count; i ++) {
            [titleArray addObject:response[i].name];
        }
        self.titleArray = titleArray;
        self.categoryArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        
    }];
}


@end
