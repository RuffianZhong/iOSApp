//
//  AccountModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//

#import "AccountModel.h"
#import "ImageHelper.h"


@implementation AccountModel


-(void)loginWithAccount:(NSString*)account password:(NSString*)password
            onSuccess:(void (^)(UserData *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"user/login";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = account;
    parameters[@"password"] = password;
    
    [[ZTHttpManager shareManager] post:api parameters:parameters parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        UserData *userData = [UserData mj_objectWithKeyValues:response];
        userData.icon = [ImageHelper randomUrl];
        success(userData);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}


-(void)registerWithAccount:(NSString*)account password:(NSString*)password confirmPassword:(NSString*)confirmPassword
            onSuccess:(void (^)(UserData *response))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"user/register";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = account;
    parameters[@"password"] = password;
    parameters[@"repassword"] = confirmPassword;

    
    [[ZTHttpManager shareManager] post:api parameters:parameters parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        
        UserData *userData = [UserData mj_objectWithKeyValues:response];
        userData.icon = [ImageHelper randomUrl];
        success(userData);
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}


-(void)logoutOnSuccess:(void (^)(void))success
              onError:(void (^)(NSNumber *code,NSString *msg))error{
    
    NSString *api = @"user/logout/json";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [[ZTHttpManager shareManager] post:api parameters:parameters parseClass:[NSDictionary class] success:^(id  _Nonnull response) {
        success();
    } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
        error(code,msg);
    }];
}

- (UserData*)getUserDataFromLocal{
    id keyValues = [NSUserDefaultsUtils objectForKey:userDataKey];
    UserData *userData =  [UserData mj_objectWithKeyValues:keyValues];
    return userData;
}

- (void)setUserDataForLocal:(UserData*) userData{
    id keyValues = [userData mj_keyValues];
    [NSUserDefaultsUtils setObject:keyValues forKey:userDataKey];
}

- (BOOL)isLogin{
    UserData *userData = [self getUserDataFromLocal];
    return userData != nil;
}

- (void)logout{
    [NSUserDefaultsUtils removeObjectForKey:userDataKey];
}

- (void)setUserAccount:(NSString*) account{
    [NSUserDefaultsUtils setObject:account forKey:userAccountKey];
}

- (NSString*)getUserAccount{
    return [NSUserDefaultsUtils objectForKey:userAccountKey];
}

@end
