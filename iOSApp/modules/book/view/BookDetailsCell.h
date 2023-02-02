//
//  BookDetailsCell.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import <UIKit/UIKit.h>
#import "ArticleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookDetailsCell : UITableViewCell
@property(nonatomic,strong) UILabel *labelTitle;
@property(nonatomic,strong) UILabel *labelDate;
@property(nonatomic,strong) UILabel *labelProgress;
@property(nonatomic,strong) UIProgressView *progressView;

@property(nonatomic,strong) ArticleData *articleData;

@end

NS_ASSUME_NONNULL_END
