//
//  HomeModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ArticleData;
@class BannerData;

@interface HomeModel : NSObject

-(void)getArticleList:(NSInteger)pageIndex
            onSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error;

-(void)getArticleTopListOnSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
                          onError:(void (^)(NSNumber *code,NSString *msg))error;

-(void)getBannerListOnSuccess:(void (^)(NSMutableArray<BannerData*> *response))success
                      onError:(void (^)(NSNumber *code,NSString *msg))error;
@end

NS_ASSUME_NONNULL_END
