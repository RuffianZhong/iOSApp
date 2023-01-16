//
//  UserData.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/16.
//

#import "UserData.h"

@implementation UserData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"uid" : @"id"
    };
}
@end
