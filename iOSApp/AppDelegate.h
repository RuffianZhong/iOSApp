//
//  AppDelegate.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/7.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;


+ (AppDelegate *)shareAppDelegate;

@end

