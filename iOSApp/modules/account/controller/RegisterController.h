//
//  RegisterController.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//
#import "BaseUIViewController.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^RegisterResult) (NSString *account);

@interface RegisterController : BaseUIViewController
@property(nonatomic,copy) RegisterResult registerResultBlock;
@end

NS_ASSUME_NONNULL_END
