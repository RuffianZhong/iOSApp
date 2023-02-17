//
//  UserData.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserData : NSObject
@property(nonatomic,assign) NSInteger uid;
@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *icon;
@property(nonatomic,assign) NSInteger coinCount;
@end

NS_ASSUME_NONNULL_END
