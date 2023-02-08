//
//  LoginViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject
@property(nonatomic,strong) AccountModel *accountModel;

- (void)loginWithAccount:(NSString*)account password:(NSString*)password success:(void (^)(UserData * data))success error:(void (^)(NSNumber *code,NSString* msg))error;
@end

NS_ASSUME_NONNULL_END
