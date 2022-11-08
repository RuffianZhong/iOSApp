//
//  UserModel.h
//  iOSApp
//  用户 Model
//  管理用户数据：增/删/改/查/其他逻辑处理
//  Created by 钟达烽 on 2022/11/8.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

/// 获取用户数据
- (UserData*)getUserData;

@end

NS_ASSUME_NONNULL_END
