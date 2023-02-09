//
//  CookieHelper.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import "CookieHelper.h"

@implementation CookieHelper

+ (void)getCookieFromResponse:(NSHTTPURLResponse*)response{
    //从 header 中获取 Cookie，保存在本地
    
    NSDictionary *allHeaderFieldsDic = response.allHeaderFields;
    NSString *cookie = allHeaderFieldsDic[@"Set-Cookie"];
    if (cookie) {
        if(cookie){
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"iOSApp_zt_cookie"];
        }
        NSLog(@"cookie : %@", cookie);
    }
}

+ (AFHTTPRequestSerializer *)setCookieForRequest:(AFHTTPRequestSerializer *)requestSerializer{
    
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"iOSApp_zt_cookie"];
    
    if(cookie){
        [requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }

    return requestSerializer;
}

@end
