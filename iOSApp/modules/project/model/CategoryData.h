//
//  CategoryData.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryData : NSObject
///一级分类ID

@property(nonatomic,assign) NSInteger cid;
@property(nonatomic,copy) NSString *name;

///二级分类列表
@property(nonatomic,strong) NSMutableArray<CategoryData*> *childArray;
@end

NS_ASSUME_NONNULL_END
