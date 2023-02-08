//
//  HUDUtils.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUDUtils : NSObject

+ (void)showToastMsg:(NSString*)msg forView:(UIView*)view;

+ (void)showToastMsg:(NSString*)msg forView:(UIView*)view durationTime:(NSTimeInterval)duration;

+(void)showLoadingForView:(UIView*)view;

+(void)hideLoadingForView:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
