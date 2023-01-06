//
//  UIImageView+Common.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/5.
//

#import "UIImageView+Common.h"

@implementation UIImageView (Common)

#pragma mark - 加载网络图片

- (void)setImageWithURL:(NSString *)imageURL{
    [self setImageWithURL:imageURL withPlaceholder:nil];
}

- (void)setImageWithURL:(NSString *)imageURL withPlaceholder:(UIImage*) placeholder{
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeholder];
}


@end
