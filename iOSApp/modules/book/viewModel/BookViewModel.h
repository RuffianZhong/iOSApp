//
//  BookViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/14.
//

#import <Foundation/Foundation.h>
#import "BookModel.h"
#import "BookData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookViewModel : NSObject
@property(nonatomic,strong) BookModel *bookModel;
@property(nonatomic,strong) NSMutableArray<BookData*> *bookArray;

- (void)getBookList;
@end

NS_ASSUME_NONNULL_END
