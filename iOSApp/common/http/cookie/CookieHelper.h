//
//  CookieHelper.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CookieHelper : NSObject

+ (void)getCookieFromResponse:(NSHTTPURLResponse*)response;

+ (AFHTTPRequestSerializer *)setCookieForRequest:(AFHTTPRequestSerializer *)requestSerializer;

@end

NS_ASSUME_NONNULL_END
