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
@property(nonatomic,assign) NSInteger timeoutInterval;


+ (HttpConfig *)sharedHttpConfig;

- (AFHTTPRequestSerializer *)makeRequestSerializer;

@end

NS_ASSUME_NONNULL_END
