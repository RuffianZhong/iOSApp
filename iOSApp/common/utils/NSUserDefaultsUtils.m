//
//  NSUserDefaultsUtils.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/16.
//

#import "NSUserDefaultsUtils.h"

@implementation NSUserDefaultsUtils

+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName{
    
    //偏好设置，键值对形式保存数据，小型数据，单例模式，将所有数据读取到内存中
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    //设置键值对
    [user setObject:value forKey:defaultName];
    
    //立即提交（默认是定时提交）
    [user synchronize];
}

+ (nullable id)objectForKey:(NSString *)defaultName{
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    //读取某个键值对
    return [user objectForKey:defaultName];
}

+ (void)removeObjectForKey:(NSString *)defaultName{
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    //移除某个键值对
    [user removeObjectForKey:defaultName];
}

@end
