//
//  UserData.h
//  iOSApp
//  用户数据类
//  Created by 钟达烽 on 2022/11/8.
//

#import <Foundation/Foundation.h>
#import "UserChild.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoUserData : NSObject

@property(nonatomic,assign) NSInteger uid;
@property(nonatomic,copy) NSString* name;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableDictionary *dictionary;
@property(nonatomic,strong) UserChild *child;

@end

NS_ASSUME_NONNULL_END
