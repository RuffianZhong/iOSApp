//
//  MeViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/16.
//

#import <Foundation/Foundation.h>
#import "UserData.h"
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeViewModel : NSObject
@property(nonatomic,strong,nullable) UserData *userData;
@property(nonatomic,strong) AccountModel *accountModel;

- (void)getUserDataFromLocal;

- (void)logout;
@end

NS_ASSUME_NONNULL_END
