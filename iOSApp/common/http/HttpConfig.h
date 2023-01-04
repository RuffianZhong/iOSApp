//
//  HttpConfig.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpConfig : NSObject
@property(nonatomic,strong) NSString *baseUrl;


+ (HttpConfig *)sharedHttpConfig;
@end

NS_ASSUME_NONNULL_END
