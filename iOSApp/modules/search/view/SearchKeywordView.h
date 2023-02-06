//
//  SearchKeywordView.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import <UIKit/UIKit.h>
#import "ZTUITagView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol SearchKeywordViewDelegate;

@interface SearchKeywordView : UIScrollView
@property(nonatomic,strong) UILabel *hotTitleLabel;
@property(nonatomic,strong) ZTUITagView *hotContentTagView;

@property(nonatomic,strong) UIView *historyTitleView;
@property(nonatomic,strong) UILabel *historyTitleLabel;
@property(nonatomic,strong) UIButton *historyEditBtn;
@property(nonatomic,strong) ZTUITagView *historyContentTagView;

@property(nonatomic,strong) NSArray<NSString *> *hotKeywordArray;
@property(nonatomic,strong) NSArray<NSString *> *historyKeywordArray;

@property(nonatomic,weak) id<SearchKeywordViewDelegate> childViewDelegate;

@end

@protocol SearchKeywordViewDelegate <NSObject>

- (void)searchKeywordView:(SearchKeywordView*) searchKeywordView editButtonClickEvent:(UIButton*)button;

-(void)searchKeywordView:(SearchKeywordView*) searchKeywordView tagViewDidSelected:(ZTUITagView *)tagView index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
