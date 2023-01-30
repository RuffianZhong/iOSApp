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

/// 数组中存储模型数据，需要说明数组中存储的模型数据类型
+ (NSDictionary *)mj_objectClassInArray{
    return @{
        @"childArray" : @"CategoryData"
    };
}

@end
