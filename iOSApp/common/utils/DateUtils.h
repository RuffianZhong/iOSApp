//
//  DateUtils.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateUtils : NSObject

/// 格式化时间戳
/// @param second 时间戳：秒
+ (NSString*)formatDateWithSecond:(NSInteger)second;

@end

NS_ASSUME_NONNULL_END
