//
//  HttpConfig.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/4.
//

#import "HttpConfig.h"
#import "CookieHelper.h"

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
        _timeoutInterval = 15;
    }
    return self;
}

- (NSString *)baseUrl{
    if(!_baseUrl){
        _baseUrl = @"https://www.wanandroid.com/";
    }
    return _baseUrl;
}

- (AFHTTPRequestSerializer *)makeRequestSerializer{
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    //超时时间
    requestSerializer.timeoutInterval = _timeoutInterval;
    // 设置自动管理Cookies
    requestSerializer.HTTPShouldHandleCookies = YES;
    
    return [CookieHelper setCookieForRequest:requestSerializer];
}

@end
