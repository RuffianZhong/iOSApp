//
//  ZTUIAlertController.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTUIAlertController : UIAlertController

@property(nonatomic,strong) UIAlertAction *cancelAction;
@property(nonatomic,strong) UIAlertAction *confirmAction;

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

- (void)cancelActionTitle:(NSString*)title;

- (void)cancelActionTitle:(NSString*)title handler:(void (^__nullable)(void))handler;

- (void)confirmActionTitle:(NSString*)title;

- (void)confirmActionTitle:(NSString*)title handler:(void (^__nullable)(void))handler;

- (void)showWithController:(UIViewController*)controller;

@end

NS_ASSUME_NONNULL_END
