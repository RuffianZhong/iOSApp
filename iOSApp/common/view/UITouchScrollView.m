//
//  UITouchScrollView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//

#import "UITouchScrollView.h"

@implementation UITouchScrollView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(!self.dragging){//当前控件不是正在拖动，事件交给下一个响应者（父控件）
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(!self.dragging){//当前控件不是正在拖动，事件交给下一个响应者（父控件）
        [self.nextResponder touchesEnded: touches withEvent:event];
    }
}

@end
