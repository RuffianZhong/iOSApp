//
//  DateUtils.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import "DateUtils.h"

@implementation DateUtils

/// 格式化时间戳
/// @param second 时间戳：秒
+ (NSString*)formatDateWithSecond:(NSInteger)second{
        
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];//时间格式化对象
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];//目标格式
    NSString *dateString = [formatter stringFromDate:date];//转化成字符串
    
    return dateString;
}
@end
