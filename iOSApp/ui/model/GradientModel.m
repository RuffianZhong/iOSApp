//
//  GradientModel.m
//  iOSApp
//  
//  Created by 钟达烽 on 2022/11/24.
//

#import "GradientModel.h"

@implementation GradientModel

- (instancetype)init{
    self = [super init];
    if(!self) return nil;
    _startPoint = CGPointMake(0, 0);
    _endPoint = CGPointMake(1, 0);
    return self;
}

- (NSArray *)gradientLocations{
    if(!_gradientLocations){
        _gradientLocations = @[@0,@1];
    }
    return _gradientLocations;
}

/// 设置渐变方向
/// @param direction 渐变方向
- (void)setDirection:(GradientDirection)direction{
    _direction = direction;
    switch (direction) {
        case GradientDirectionRight2Left:
            _startPoint = CGPointMake(1, 0);
            _endPoint = CGPointMake(0, 0);
            break;
        case GradientDirectionTop2Bottom:
            _startPoint = CGPointMake(0, 0);
            _endPoint = CGPointMake(0, 1);
            break;
        case GradientDirectionBottom2Top:
            _startPoint = CGPointMake(0, 1);
            _endPoint = CGPointMake(0, 0);
            break;
        case GradientDirectionLeftTop2RightBottom:
            _startPoint = CGPointMake(0, 0);
            _endPoint = CGPointMake(1, 1);
            break;
        case GradientDirectionLeftBottom2RightTop:
            _startPoint = CGPointMake(0, 1);
            _endPoint = CGPointMake(1, 0);
            break;
        case GradientDirectionRightTop2LeftBottom:
            _startPoint = CGPointMake(1, 0);
            _endPoint = CGPointMake(0, 1);
            break;
        case GradientDirectionRightBottom2LeftTop:
            _startPoint = CGPointMake(1, 1);
            _endPoint = CGPointMake(0, 0);
            break;
        case GradientDirectionLeft2Right:
        default:
            _startPoint = CGPointMake(0, 0);
            _endPoint = CGPointMake(1, 0);
            break;
    }
}


- (void)setGradientColors:(NSMutableArray*)gradientColors{
    if(gradientColors){
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        //数量不够，手动复制2份
        if(gradientColors.count < 2){
            [gradientColors addObjectsFromArray:gradientColors];
        }
        
        //处理数据类型
        for (int i = 0; i < gradientColors.count; i++) {
            UIColor *color = [gradientColors objectAtIndex:i];
            [array addObject:(__bridge id)[color CGColor]];
        }
        
        _gradientColors = array;
    }
}

@end
