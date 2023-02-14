//
//  BaseUIViewController.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/12.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseUIViewController : UIViewController

@property(nonatomic,strong) BaseNavigationBarView *navigationBarView;//导航栏View

#pragma mark - BaseNavigationBarView 统一提供外层方法，方便后续维护/替换
-(void)setNavigationBarHiden:(BOOL)hiden;
-(void)setNavigationBarBackground:(UIColor*)color;
-(void)setNavigationTitle:(NSString*)title;
-(void)setNavigationLeftImage:(UIImage*)image;
-(void)setNavigationRightImage:(UIImage*)image;
-(void)setNavigationLeftBarHandler:(void(^)(NSInteger index))handler;
-(void)setNavigationRightBarHandler:(void(^)(NSInteger index))handler;


@end

NS_ASSUME_NONNULL_END
