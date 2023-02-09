//
//  MeViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/16.
//

#import "MeViewModel.h"

@implementation MeViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _accountModel = [[AccountModel alloc] init];
    _userData = [[UserData alloc] init];
    return self;
}

- (void)getUserDataFromLocal{
    UserData *userData = [_accountModel getUserDataFromLocal];
    self.userData = userData;
}

- (void)logout{
    [_accountModel logout];
    self.userData = nil;
}

@end
