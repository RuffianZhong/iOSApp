//
//  DemoView.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/8.
//

#import <UIKit/UIKit.h>
#import "DemoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoView : UIView

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) DemoViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
