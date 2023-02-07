//
//  KeyboardUtils.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/7.
//

#import "KeyboardUtils.h"

@implementation KeyboardUtils

+ (void)hidenKeyboard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
