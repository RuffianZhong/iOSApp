//
//  KnowledgeChildController.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/30.
//
#import "BaseUIViewController.h"
#import <UIKit/UIKit.h>
#import "CategoryData.h"

NS_ASSUME_NONNULL_BEGIN

@interface KnowledgeChildController : BaseUIViewController
@property(nonatomic,strong) CategoryData *categoryData;
@property(nonatomic,assign) NSInteger index;
@end

NS_ASSUME_NONNULL_END
