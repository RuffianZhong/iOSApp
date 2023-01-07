//
//  UITabChildView.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabChildView : UIView

@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UIView *indicator;

@property(nonatomic,assign) BOOL select;
@end

NS_ASSUME_NONNULL_END
