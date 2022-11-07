//
//  ZTHttpManager.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTHttpManager : NSObject

//单例实例
+ (instancetype)shareManager;

//网络请求

- (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters parseClass:(Class)clazz success:(void (^)(id response))successBlock error:(void (^)(NSNumber *code,NSString *msg))errorBlock;

- (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters parseClass:(Class)clazz success:(void (^)(id response))successBlock error:(void (^)(NSNumber *code,NSString *msg))errorBlock;

@end




NS_ASSUME_NONNULL_END
