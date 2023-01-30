//
//  NavData.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import "NavData.h"

@implementation NavData

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"articleArray" : @"articles"
    };
}

/// 数组中存储模型数据，需要说明数组中存储的模型数据类型
+ (NSDictionary *)mj_objectClassInArray{
    return @{
        @"articleArray" : @"ArticleData"
    };
}
@end
