//
//  LifecycleView.m
//  mvvm
//
//  Created by 钟达烽 on 2022/11/5.
//

#import "LifecycleView.h"

@implementation LifecycleView

- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0, 0, 1, 1);
    self = [super initWithFrame:frame];
    if (!self) return nil;
    /// 透明度为0不会渲染
    self.alpha = 0.0;
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    /// newWindow == nil 时从屏幕移除
    if(!newWindow){
        if(_lifecycleDelegate){
            [_lifecycleDelegate didRemoveFromWindow];
        }
    }
}

@end
