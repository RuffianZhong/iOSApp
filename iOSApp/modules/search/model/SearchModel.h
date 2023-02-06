//
//  SearchModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import <Foundation/Foundation.h>
#import "ArticleData.h"
#import "SearchKeywordData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchModel : NSObject

//获取搜索热词
-(void)getHotKeywordOnSuccess:(void (^)(NSMutableArray<NSString*> *response))success
                      onError:(void (^)(NSNumber *code,NSString *msg))error;

//根据关键词获取文章列表
-(void)getArticleList:(NSString*)keyword
            onSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error;


@end

NS_ASSUME_NONNULL_END
