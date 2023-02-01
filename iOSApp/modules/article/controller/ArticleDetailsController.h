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

@interface ArticleDetailsController : UIViewController
@property(nonatomic,strong) ArticleData *articleData;
@end

NS_ASSUME_NONNULL_END
