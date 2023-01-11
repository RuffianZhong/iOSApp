//
//  ProjectViewModel.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import <Foundation/Foundation.h>
#import "ProjectModel.h"
#import "CategoryData.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectViewModel : NSObject

@property(nonatomic,strong) ProjectModel *projectModel;
@property(nonatomic,strong) NSMutableArray<CategoryData*> *categoryArray;

@property(nonatomic,strong) NSMutableArray<NSString*> *titleArray;

- (void)getCategoryList;

@end

NS_ASSUME_NONNULL_END
