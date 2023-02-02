//
//  BookDetailsViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import "BookDetailsViewModel.h"

@implementation BookDetailsViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;

    _bookModel = [[BookModel alloc]init];
    _dataArray = [NSMutableArray array];
    return self;
}

-(void)getBookArticleList:(NSInteger)categoryId{
    [_bookModel getBookArticleList:categoryId onSuccess:^(NSMutableArray<ArticleData *> * _Nonnull response) {
        self.dataArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        
    }];
}


@end
