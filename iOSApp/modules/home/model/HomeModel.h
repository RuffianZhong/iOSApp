//
//  HomeModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ArtcleData;
@class BannerData;

@interface HomeModel : NSObject

-(void)getArticleList:(NSInteger)pageIndex
            onSuccess:(void (^)(NSMutableArray<ArtcleData*> *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error;

-(void)getArticleTopListOnSuccess:(void (^)(NSMutableArray<ArtcleData*> *response))success
                          onError:(void (^)(NSNumber *code,NSString *msg))error;

-(void)getBannerListOnSuccess:(void (^)(NSMutableArray<BannerData*> *response))success
                      onError:(void (^)(NSNumber *code,NSString *msg))error;
@end

NS_ASSUME_NONNULL_END
