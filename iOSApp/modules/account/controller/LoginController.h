//
//  LoginController.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/7.
//
#import "BaseUIViewController.h"
#import <UIKit/UIKit.h>
#import "UserData.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^LoginResult) (UserData *userData);

@interface LoginController : BaseUIViewController
@property(nonatomic,copy) LoginResult loginResultBlock;
@end

NS_ASSUME_NONNULL_END
