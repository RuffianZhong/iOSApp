//
//  UIImage+Common.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+(void)load{
    Method originalSelector = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method swizzledSelector = class_getClassMethod([UIImage class], @selector(swizzled_common_imageNamed:));
    method_exchangeImplementations(originalSelector, swizzledSelector);
}

/// 加载图片交换方法：实现加载多语言图片
/// @param name 图片名称
+(UIImage *)swizzled_common_imageNamed:(NSString *)name{
    UIImage *image = nil;
    
    NSString *language = [AppDelegate shareAppDelegate].language;
    if (![language isEqualToString:Language_en]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_image", language] ofType:@"bundle"];
        if (path) {
            NSBundle *bundle = [NSBundle bundleWithPath:path];

            if (@available(iOS 13.0, *)) {
               image = [UIImage imageNamed:name inBundle:bundle withConfiguration:nil];
            } else {
              image = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
            }
        }
    }
    if (image == nil) {
        return [UIImage swizzled_common_imageNamed:name];
    }else{
        return image;
    }
}


/// UIImage 着色
/// @param color 目标颜色
- (UIImage*)imageWithTint:(UIColor*)color{

    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [self drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return result;
}

@end
