//
//  BaseNavigationBarView.h
//  iOSApp
//  自定义 NavigationBar 控件（原生自带的是在太恶心了）
//  Created by 钟达烽 on 2023/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LeftBarHandler) (NSInteger index);
typedef void(^RightBarHandler) (NSInteger index);

@interface BaseNavigationBarView : UIView

@property(nonatomic,copy) LeftBarHandler leftBarHandler;
@property(nonatomic,copy) RightBarHandler rightBarHandler;


- (void)setCustomLeftBarView:(UIView*)leftBarView;

- (void)setCustomRightBarView:(UIView*)rightBarView;

- (void)setCustomTitleView:(UIView*)titleView;

- (void)setTitleText:(NSString*)title;

-(void)setLeftImage:(UIImage*)leftImage;

-(void)setRightImage:(UIImage*)rightImage;

-(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
