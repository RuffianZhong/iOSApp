//
//  LoginViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//

#import "LoginViewModel.h"
#import "NSUserDefaultsUtils.h"

@implementation LoginViewModel

- (instancetype)init{
    self = [super init];
    if(self){
        _accountModel = [[AccountModel alloc] init];
    }
    return self;
}

- (void)loginWithAccount:(NSString*)account password:(NSString*)password success:(void (^)(UserData * data))success error:(void (^)(NSNumber *code,NSString* msg))error{
    
    [_accountModel loginWithAccount:account password:password onSuccess:^(UserData * _Nonnull response) {
        
        self.userData = response;
        [self.accountModel setUserDataForLocal:response];

        success(response);
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}

- (void)getUserAccount{
   self.account = [_accountModel getUserAccount];
}

@end
