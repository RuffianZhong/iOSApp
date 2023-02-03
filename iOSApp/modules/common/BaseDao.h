//
//  BaseDao.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/3.
//

#import <Foundation/Foundation.h>
#import "DBHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseDao : NSObject
@property(nonatomic,strong,readwrite) DBHelper *dbHelper;
@end

NS_ASSUME_NONNULL_END
