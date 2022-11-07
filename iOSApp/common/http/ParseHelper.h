//
//  ParseHelper.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import <Foundation/Foundation.h>
#import "ZTResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseHelper : NSObject

//解析数据（泛型）
+ (ZTResponse<Class>*)parseResponse:(id)responseObject class:(Class)clazz;

@end

NS_ASSUME_NONNULL_END
