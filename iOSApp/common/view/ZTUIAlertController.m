//
//  ZTUIAlertController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/9.
//

#import "ZTUIAlertController.h"

@implementation ZTUIAlertController

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message{
    return [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
}

- (void)cancelActionTitle:(NSString*)title{
    [self cancelActionTitle:title handler:nil];
}

- (void)cancelActionTitle:(NSString*)title handler:(void (^)(void))handler{
    _cancelAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(handler) handler();
    }];
    
    [self addAction:_cancelAction];
}

- (void)confirmActionTitle:(NSString*)title{
    [self confirmActionTitle:title handler:nil];
}

- (void)confirmActionTitle:(NSString*)title handler:(void (^)(void))handler{
    _confirmAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(handler) handler();
    }];
    [self addAction:_confirmAction];
}

- (void)showWithController:(UIViewController*)controller{
    [controller presentViewController:self animated:YES completion:nil];
}

@end
