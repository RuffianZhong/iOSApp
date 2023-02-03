//
//  BaseDao.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/3.
//

#import "BaseDao.h"

@implementation BaseDao

- (instancetype)init{
    if (self == [super init]) {
        //加载所需资源
        _dbHelper = [DBHelper shareHelper];
    }
    return self;
}


@end
