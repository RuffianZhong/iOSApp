//
//  HUDUtils.m
//  iOSApp
//  MBProgressHUD 简单使用：https://www.hangge.com/blog/cache/detail_2031.html
//  Created by 钟达烽 on 2023/2/8.
//

#import "HUDUtils.h"
#import "MBProgressHUD.h"

@implementation HUDUtils

+ (void)showToastMsg:(NSString*)msg forView:(UIView*)view{
    [HUDUtils showToastMsg:msg forView:view durationTime:1.0f];
}

+ (void)showToastMsg:(NSString*)msg forView:(UIView*)view durationTime:(NSTimeInterval)duration{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;//纯文本
    hud.label.text = msg;//内容
    [hud hideAnimated:YES afterDelay:duration];//展示时长
}

+(void)showLoadingForView:(UIView*)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+(void)hideLoadingForView:(UIView*)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}


@end
