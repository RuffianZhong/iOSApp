//
//  ProjectModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import <Foundation/Foundation.h>
#import "ArtcleData.h"
#import "CategoryData.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectModel : NSObject


-(void)getArticleList:(NSInteger)pageIndex categoryId:(NSInteger)categoryId
            onSuccess:(void (^)(NSMutableArray<ArtcleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error;

-(void)getCategoryListOnSuccess:(void (^)(NSMutableArray<CategoryData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error;


@end

NS_ASSUME_NONNULL_END
