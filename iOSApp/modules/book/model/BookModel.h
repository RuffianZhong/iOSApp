//
//  BookModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/14.
//

#import <Foundation/Foundation.h>
#import "BookData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookModel : NSObject

///教程列表
- (void)getBookLisOnSuccess:(void (^)(NSMutableArray<BookData*> *response))success
                    onError:(void (^)(NSNumber *code,NSString *msg))error;

@end

NS_ASSUME_NONNULL_END
