//
//  BookViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/14.
//

#import "BookViewModel.h"

@implementation BookViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _bookModel = [[BookModel alloc] init];
    _bookArray = [NSMutableArray array];
    
    return self;
}

- (void)getBookList{
    [_bookModel getBookLisOnSuccess:^(NSMutableArray<BookData *> * _Nonnull response) {
        self.bookArray = response;
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        
    }];
}

@end
