//
//  BookDetailsViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import <Foundation/Foundation.h>
#import "BookModel.h"
#import "ArticleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookDetailsViewModel : NSObject
@property(nonatomic,strong) BookModel *bookModel;
@property(nonatomic,strong) NSMutableArray<ArticleData*> *dataArray;
@end

NS_ASSUME_NONNULL_END
