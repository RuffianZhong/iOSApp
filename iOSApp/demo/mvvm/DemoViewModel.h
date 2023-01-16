//
//  DemoViewModel.h
//  iOSApp
//  demo ViewModel 类
//  Created by 钟达烽 on 2022/11/8.
//

#import <Foundation/Foundation.h>
#import "DemoUserData.h"
#import "DemoUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoViewModel : NSObject

@property(nonatomic,strong) DemoUserModel *userModel;
@property(nonatomic,strong) DemoUserData *userData;
@property(nonatomic,assign) NSInteger updateCount;

- (void)showUserInfo;
- (void)updateUserInfo:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
