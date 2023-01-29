//
//  KnowledgeModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import <Foundation/Foundation.h>
#import "CategoryData.h"
#import "NavData.h"
#import "ArticleData.h"
#import "ImageHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface KnowledgeModel : NSObject

///获取体系分类列表
-(void)getSystemListOnSuccess:(void (^)(NSMutableArray<CategoryData*> *response))success
                      onError:(void (^)(NSNumber *code,NSString *msg))error;

///获取导航分类列表
-(void)getNavListOnSuccess:(void (^)(NSMutableArray<NavData*> *response))success
                   onError:(void (^)(NSNumber *code,NSString *msg))error;

///获取项目文章列表
///projectId：项目分类ID
-(void)getArticleList:(NSInteger)pageIndex categoryId:(NSInteger)categoryId
            onSuccess:(void (^)(NSMutableArray<ArticleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error;

@end

NS_ASSUME_NONNULL_END
