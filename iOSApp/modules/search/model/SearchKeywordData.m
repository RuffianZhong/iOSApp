//
//  SearchKeywordData.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import "SearchKeywordData.h"

@implementation SearchKeywordData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"kid" : @"id",
        @"value" : @"name"
    };
}
@end
