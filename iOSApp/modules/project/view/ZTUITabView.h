//
//  ZTUITabView.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZTUITabViewDelegate;

@interface ZTUITabView : UIView

@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) NSMutableArray<NSString*> *dataArray;
@property(nonatomic,weak) id<ZTUITabViewDelegate> delegate;

/// 设置数据
/// @param dataArray 数据源
- (void)tabViewDataArray:(NSMutableArray *)dataArray;

/// 选中某个下标
/// @param index 下标
- (void)tabViewSelectIndex:(NSInteger)index;

@end


@protocol ZTUITabViewDelegate<NSObject>
@optional

//UITabView 选中事件
-(void)tabViewDidSelected:(ZTUITabView *)tabView index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
