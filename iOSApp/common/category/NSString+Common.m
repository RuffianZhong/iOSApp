//
//  NSString+Common.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "NSString+Common.h"

@implementation NSString (Common)

/// 文本国际化
- (NSString *)I18N{
    
    NSString *language = [AppDelegate shareAppDelegate].language;
    
//    if ([language isEqual:Language_zh]) {
//        language = @"zh-Hant";
//    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
    if (!path) {
        return [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:Language_en ofType:@"lproj"]] localizedStringForKey:(self) value:nil table:nil];
    }
    return [[NSBundle bundleWithPath:path] localizedStringForKey:(self) value:nil table:nil];
}


@end
