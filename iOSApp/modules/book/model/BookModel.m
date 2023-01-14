//
//  BookModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/14.
//

#import "BookModel.h"

@implementation BookModel

///教程列表
- (void)getBookLisOnSuccess:(void (^)(NSMutableArray<BookData*> *response))success
                                           onError:(void (^)(NSNumber *code,NSString *msg))error{
    NSString *api = @"chapter/547/sublist/json";
    
    [[ZTHttpManager shareManager] get:api parseClass:[NSMutableArray class] success:^(id  _Nonnull response) {
        
        NSMutableArray<BookData*> *dataArray = [BookData mj_objectArrayWithKeyValuesArray:response];
        success(dataArray);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}


@end
