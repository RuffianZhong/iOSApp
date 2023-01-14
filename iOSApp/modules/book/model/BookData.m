//
//  BookData.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/14.
//

#import "BookData.h"

@implementation BookData

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"bid" : @"id"
    };
}

@end
