//
//  RegisterViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel

- (instancetype)init{
    self = [super init];
    if(self){
        _accountModel = [[AccountModel alloc] init];
    }
    return self;
}

- (void)registerWithAccount:(NSString*)account password:(NSString*)password confirmPsw:(NSString*)confirmPsw success:(void (^)(void))success error:(void (^)(NSNumber *code,NSString* msg))error{
    
    [_accountModel registerWithAccount:account password:password confirmPassword:confirmPsw onSuccess:^(UserData * _Nonnull response) {
        [self.accountModel setUserAccount:account];
        success();
    } onError:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}
@end
