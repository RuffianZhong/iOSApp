//
//  ZTNSProxy.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTNSProxy : NSProxy
- (instancetype)initWithObjec:(id)object;

+ (instancetype)proxyWithObject:(id)object;
@end

NS_ASSUME_NONNULL_END
