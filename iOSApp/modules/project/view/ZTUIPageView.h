//
//  ZTUIPageView.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol ZTUIPageViewDelegate;

@interface ZTUIPageView : UIView

@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) NSMutableArray *dataArray;

//代理
@property (nonatomic,weak) id<ZTUIPageViewDelegate> delegate;

/// 设置数据
/// @param dataArray 数据源
- (void)pageViewDataArray:(NSMutableArray *)dataArray;

/// 选中某个下标
/// @param index 下标
- (void)pageViewSelectIndex:(NSInteger)index;

@end

@protocol ZTUIPageViewDelegate<NSObject>
@required
//返回某个下表对应的Controller
-(UIViewController *)pageViewChildViewController:(ZTUIPageView *) pageView index:(NSInteger) index;

@optional
//选中下标
-(void)pageViewDidSelected:(ZTUIPageView *)pageView index:(NSInteger)index;

@end


NS_ASSUME_NONNULL_END
