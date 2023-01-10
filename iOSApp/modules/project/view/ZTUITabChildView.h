//
//  ZTUITabChildView.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZTUITabChildViewDelegate;

@interface ZTUITabChildView : UIView

@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UIView *indicator;

@property(nonatomic,assign) BOOL select;
@property(nonatomic,assign) NSString *title;

//代理
@property (nonatomic,weak) id<ZTUITabChildViewDelegate> delegate;

//获取控件宽度
- (CGFloat)viewWidth;

@end

@class ZTUITabChildView;
@protocol ZTUITabChildViewDelegate<NSObject>

@required
//点击事件
-(void)tabChildViewDidClick:(ZTUITabChildView *)tabChildView;

@end

NS_ASSUME_NONNULL_END
