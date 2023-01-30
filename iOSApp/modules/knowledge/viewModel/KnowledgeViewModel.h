//
//  KnowledgeViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import <Foundation/Foundation.h>
#import "KnowledgeData.h"
#import "KnowledgeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KnowledgeViewModel : NSObject
@property(nonatomic,strong) KnowledgeData *knowledgeData;
@property(nonatomic,strong) KnowledgeModel *knowledgeModel;

///获取分类列表
- (void)getCategoryList;

///获取导航列表
- (void)getNavList;

///获取列表标题
- (NSString*)titleForIndex:(NSInteger)index withType:(NSInteger)type;

///获取列表标签
- (NSArray<NSString*>*)tagArrayForIndex:(NSInteger)index withType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
