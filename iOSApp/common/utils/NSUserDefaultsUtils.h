//
//  NSUserDefaultsUtils.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaultsUtils : NSObject

+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName;

+ (nullable id)objectForKey:(NSString *)defaultName;

+ (void)removeObjectForKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END
