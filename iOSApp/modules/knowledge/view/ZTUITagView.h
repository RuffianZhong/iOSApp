//
//  ZTUITagView.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZTUITagViewDelegate;

@interface ZTUITagView : UIView

@property(nonatomic,strong) NSMutableArray<NSString*> *dataArray;
@property(nonatomic,assign) NSInteger index;

@property(nonatomic,weak) id<ZTUITagViewDelegate> delegate;

- (void)tagViewDataArray:(NSMutableArray<NSString*> *)dataArray;

@end

@class ZTUITagView;
@protocol ZTUITagViewDelegate<NSObject>
@optional

//选中事件
-(void)tagViewDidSelected:(ZTUITagView *)tabView index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END