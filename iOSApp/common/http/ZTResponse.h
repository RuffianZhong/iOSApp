//
//  ZTResponse.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTResponse<__covariant ObjectType> : NSObject

@property(nonatomic,strong) NSNumber *code;//状态码
@property(nonatomic,strong) NSString *msg;//描述信息
@property(nonatomic,strong) ObjectType data;//业务数据模型

@end

NS_ASSUME_NONNULL_END
