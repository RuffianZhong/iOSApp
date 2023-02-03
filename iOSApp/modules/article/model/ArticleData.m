//
//  ArtcleData.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import "ArticleData.h"

@implementation ArticleData

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"aid" : @"id",
        @"userName" : @"shareUser",
        @"date" : @"niceDate",
        @"cover" : @"envelopePic"
    };
}

@end
