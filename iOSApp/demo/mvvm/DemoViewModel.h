//
//  DemoViewModel.h
//  iOSApp
//  demo ViewModel 类
//  Created by 钟达烽 on 2022/11/8.
//

#import <Foundation/Foundation.h>
#import "UserData.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoViewModel : NSObject

@property(nonatomic,strong) UserModel *userModel;
@property(nonatomic,strong) UserData *userData;
@property(nonatomic,assign) NSInteger updateCount;

- (void)showUserInfo;
- (void)updateUserInfo:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
