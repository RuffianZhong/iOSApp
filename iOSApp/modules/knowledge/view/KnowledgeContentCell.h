//
//  KnowledgeContentCell.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import <UIKit/UIKit.h>
#import "ZTUITagView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KnowledgeContentCell : UITableViewCell
@property(nonatomic,strong) UILabel *labelTitle;
@property(nonatomic,strong) ZTUITagView *tagView;

@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) NSArray<NSString*> *tagArray;

- (void)setTitle:(NSString *)title tagArray:(NSArray<NSString*> *)tagArray;

@end

NS_ASSUME_NONNULL_END
