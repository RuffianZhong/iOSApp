//
//  AccountModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountModel : NSObject


-(void)loginWithAccount:(NSString*)account password:(NSString*)password
            onSuccess:(void (^)(UserData *response))success
                onError:(void (^)(NSNumber *code,NSString *msg))error;


-(void)registerWithAccount:(NSString*)account password:(NSString*)password confirmPassword:(NSString*)confirmPassword
            onSuccess:(void (^)(UserData *response))success
                   onError:(void (^)(NSNumber *code,NSString *msg))error;


-(void)logoutOnSuccess:(void (^)(void))success
               onError:(void (^)(NSNumber *code,NSString *msg))error;

@end

NS_ASSUME_NONNULL_END
