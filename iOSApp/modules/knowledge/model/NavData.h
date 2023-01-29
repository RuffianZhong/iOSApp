//
//  NavData.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import <Foundation/Foundation.h>
#import "ArticleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface NavData : NSObject
///导航列表（文章列表）
@property(nonatomic,strong) NSMutableArray<ArticleData*> * articleArray;
///导航ID
@property(nonatomic,assign) NSInteger cid;
///导航名称
@property(nonatomic,copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
