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


/// Image 着色
/// @param color 目标颜色
-(UIImage*)imageWithColor:(UIColor*)color{
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 根据颜色生成纯色 Image
/// @param size 大小
/// @param color 颜色值
/// @param cornerRadius 圆角
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    
    UIView *renderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    renderView.layer.cornerRadius = cornerRadius;
    renderView.backgroundColor = color;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [renderView.layer renderInContext:context];
    
    UIImage *renderImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return renderImage;
}

@end
