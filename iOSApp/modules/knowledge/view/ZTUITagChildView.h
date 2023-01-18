//
//  ZTUITagChildView.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZTUITagChildViewDelegate;

@interface ZTUITagChildView : UIView
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,assign) NSString *title;

//代理
@property (nonatomic,weak) id<ZTUITagChildViewDelegate> delegate;

- (void)setTitle:(NSString *)title;

- (CGFloat)viewHeight;

- (CGFloat)viewWidth;

@end


@class ZTUITagChildView;
@protocol ZTUITagChildViewDelegate<NSObject>

@required
//点击事件
-(void)tagChildViewDidClick:(ZTUITagChildView *)tabChildView;

@end

NS_ASSUME_NONNULL_END
