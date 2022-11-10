//
//  DemoViewModel.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/11/8.
//

#import "DemoViewModel.h"

@implementation DemoViewModel

- (instancetype)init{
    self = [super init];
    if(!self)return nil;
    
    _userModel = [[UserModel alloc]init];
    _userData = [[UserData alloc]init];
    
    return self;
}

- (void)showUserInfo{
    self.userData = _userModel.getUserData;
}

- (void)updateUserInfo:(NSString *)name{
    
    ///通过点语法更新
    self.userData.name = name;
    
    ///只能通过 self + 属性 更新
    //int random = 500 + arc4random() % (1000-500+1);
    //self.updateCount = random;///YES
    //_updateCount = random;///NO
    
 
//    _userData.name = name;///YES ：一级
//    _userData.child.name = name;///NO ： 二级
//    _userData.child = [[UserChild alloc]init];///YES ：更新 child 可以
    
    
    /// 以下这种方式会通知多次：因为 data / data.name / data.uid 都是属性，并且都修改了
//    UserData *data = [[UserData alloc]init];
//    data.name = name;
//    data.uid = 123;
//
//    _userData = data;
//    self.userData = data;
}

@end
