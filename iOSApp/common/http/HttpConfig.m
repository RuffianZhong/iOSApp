//
//  HttpConfig.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/4.
//

#import "HttpConfig.h"

@implementation HttpConfig


+ (HttpConfig *)sharedHttpConfig
{
    static HttpConfig *httpConfig = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        httpConfig = [[HttpConfig alloc] init];
    });
    return httpConfig;
}

- (id)init{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (NSString *)baseUrl{
    if(!_baseUrl){
        _baseUrl = @"https://www.wanandroid.com/";
    }
    return _baseUrl;
}
@end
