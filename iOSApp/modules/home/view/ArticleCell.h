//
//  ArtcleCell.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ArticleData;

@interface ArticleCell : UITableViewCell

@property(nonatomic,strong) UIImageView *ivUserIcon;
@property(nonatomic,strong) UILabel *labelUserName;
@property(nonatomic,strong) UILabel *labelTitle;
@property(nonatomic,strong) UILabel *labelDate;
@property(nonatomic,strong) UILabel *labelSubTitle;
@property(nonatomic,strong) UIImageView *ivCorver;
@property(nonatomic,strong) UILabel *labelChapter;//主-副标签
@property(nonatomic,strong) UIImageView *ivCollect;//收藏

@property(nonatomic,strong) ArticleData *data;

@end

NS_ASSUME_NONNULL_END
