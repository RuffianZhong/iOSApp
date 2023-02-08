//
//  RegisterViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewModel : NSObject

@property(nonatomic,strong) AccountModel *accountModel;

- (void)registerWithAccount:(NSString*)account password:(NSString*)password confirmPsw:(NSString*)confirmPsw success:(void (^)(void))success error:(void (^)(NSNumber *code,NSString* msg))error;

@end

NS_ASSUME_NONNULL_END
