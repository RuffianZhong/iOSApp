//
//  MeViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/16.
//

#import <Foundation/Foundation.h>
#import "UserData.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeViewModel : NSObject
@property(nonatomic,strong,nullable) UserData *userData;
@property(nonatomic,strong) UserModel *userModel;

- (UserData*)getUserDataFromLocal;

- (void)setUserDataForLocal:(UserData*) userData;

- (void)logout;
@end

NS_ASSUME_NONNULL_END
