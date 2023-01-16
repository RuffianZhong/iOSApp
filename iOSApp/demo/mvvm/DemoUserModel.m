//
//  UserModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/8.
//

#import "DemoUserModel.h"

@implementation DemoUserModel

- (DemoUserData *)getUserData{
    
    int random = 500 + arc4random() % (1000-500+1);
    NSString *name =[ NSString stringWithFormat:@"ruffian-%d",random];
    
    DemoUserData *userData = [[DemoUserData alloc]init];
    userData.uid = random;
    userData.name = name;
    
    return userData;
}

@end
