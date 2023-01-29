//
//  KnowledgeData.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import <Foundation/Foundation.h>
#import "CategoryData.h"
#import "NavData.h"

NS_ASSUME_NONNULL_BEGIN

@interface KnowledgeData : NSObject
///分类列表
@property(nonatomic,strong) NSMutableArray<CategoryData*> *categoryArray;
///导航列表
@property(nonatomic,strong) NSMutableArray<NavData*> *navArray;
@end

NS_ASSUME_NONNULL_END
