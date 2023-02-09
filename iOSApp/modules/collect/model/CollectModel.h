//
//  CollectModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import <Foundation/Foundation.h>
#import "ArticleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectModel : NSObject

-(void)getArticleList:(NSInteger)pageIndex
            onSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error;

- (void)collectOrCancelArticle:(NSInteger)articleId collect:(BOOL)collect onSuccess:(void(^)(void))success onError:(void (^)(NSNumber *code,NSString *msg))error;

@end

NS_ASSUME_NONNULL_END
