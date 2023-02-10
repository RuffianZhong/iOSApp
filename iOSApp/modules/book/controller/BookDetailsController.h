//
//  BookDetailsController.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//
#import "BaseUIViewController.h"
#import <UIKit/UIKit.h>
#import "BookData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookDetailsController : BaseUIViewController
@property(nonatomic,strong) BookData *bookData;
@end

NS_ASSUME_NONNULL_END
