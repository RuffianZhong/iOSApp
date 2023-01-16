//
//  AppDelegate.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import <UIKit/UIKit.h>

typedef NSString* Language;
static const Language Language_zh = @"zh-Hans";
static const Language Language_en = @"en";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong) UIWindow *window;
@property(nonatomic,strong) UINavigationController *navController;
@property(nonatomic,copy) NSString *language;

/// 修改多语言
- (void)setAppLanguage:(NSString *)language;


+ (AppDelegate *)shareAppDelegate;
- (void)startToMainPage;

@end

