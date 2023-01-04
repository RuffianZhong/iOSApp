//
//  ArtcleData.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import "ArtcleData.h"

@implementation ArtcleData

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"userName" : @"shareUser",
        @"date" : @"niceDate",
        @"cover" : @"envelopePic"
    };
}

@end
