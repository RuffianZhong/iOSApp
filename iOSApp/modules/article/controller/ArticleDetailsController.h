//
//  ArticleDetailsController.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/1.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ArticleData.h"

NS_ASSUME_NONNULL_BEGIN

//页面反向传值：定义一个Block
typedef void(^ProgressUpdateBlock)(CGFloat progress);

@interface ArticleDetailsController : UIViewController
@property(nonatomic,strong) ArticleData *articleData;

//页面反向传值：添加一个Block属性
@property(nonatomic,copy) ProgressUpdateBlock progressUpdateBlock;
@end

NS_ASSUME_NONNULL_END
