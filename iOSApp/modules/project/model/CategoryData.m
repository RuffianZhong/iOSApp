//
//  CategoryData.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import "CategoryData.h"

@implementation CategoryData

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"cid" : @"id",
        @"childArray" : @"children"
    };
}

@end
