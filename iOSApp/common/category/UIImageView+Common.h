//
//  UIImageView+Common.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Common)

#pragma mark - 加载网络图片
- (void)setImageWithURL:(NSString *)imageURL;

- (void)setImageWithURL:(NSString *)imageURL withPlaceholder:(UIImage*) placeholder;



@end

NS_ASSUME_NONNULL_END
