//
//  MeViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/16.
//

#import "MeViewModel.h"

@implementation MeViewModel


- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _userModel = [[UserModel alloc] init];
    _userData = [[UserData alloc] init];
    return self;
}

- (UserData*)getUserDataFromLocal{
    
    id keyValues = [NSUserDefaultsUtils objectForKey:userDataKey];
    _userData =  [UserData mj_objectWithKeyValues:keyValues];
    return _userData;
}

- (void)setUserDataForLocal:(UserData*) userData{
    id keyValues = [userData mj_keyValues];
    [NSUserDefaultsUtils setObject:keyValues forKey:userDataKey];
    self.userData = userData;
}

- (void)logout{
    [NSUserDefaultsUtils removeObjectForKey:userDataKey];
    self.userData = nil;
}





@end
