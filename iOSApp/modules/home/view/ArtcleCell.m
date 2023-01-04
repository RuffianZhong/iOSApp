//
//  ArtcleCell.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import "ArtcleCell.h"
#import "ArtcleData.h"

@implementation ArtcleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initViews];
    }
    return self;
}

- (void)initViews{
    //头像
    _ivUserIcon = [[UIImageView alloc] init];
    _ivUserIcon.backgroundColor = [UIColor redColor];
    [_ivUserIcon zt_cornerWithCornerRadii:20];
    [self.contentView addSubview:_ivUserIcon];
    [_ivUserIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(40);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.contentView).offset(10);
    }];
    //昵称
    _labelUserName = [[UILabel alloc] init];
    _labelUserName.backgroundColor = [UIColor greenColor];
    [_labelUserName setText:@"_labelUserName"];
    [self.contentView addSubview:_labelUserName];
    [_labelUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_ivUserIcon);
        make.left.mas_equalTo(_ivUserIcon.mas_right).offset(6);
    }];
    //日期
    _labelDate = [[UILabel alloc] init];
    _labelDate.backgroundColor = [UIColor blueColor];
    [_labelDate setText:@"_labelDate"];
    [self.contentView addSubview:_labelDate];
    [_labelDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.centerY.mas_equalTo(_ivUserIcon);
    }];
    //封面
    _ivCorver = [[UIImageView alloc] init];
    _ivCorver.backgroundColor = [UIColor purpleColor];
    [_ivCorver setContentMode:UIViewContentModeScaleAspectFill];
    [self.contentView addSubview:_ivCorver];
    [_ivCorver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(100);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(_ivUserIcon.mas_bottom).offset(6);
    }];
    //主标题
    _labelTitle = [[UILabel alloc] init];
    _labelTitle.backgroundColor = [UIColor greenColor];
    [_labelTitle setText:@"_labelTitle_labelTitle_labelTitle_labelTitle_labelTitle_labelTitle_labelTitle_labelTitle_labelTitle_labelTitle"];
    _labelTitle.numberOfLines = 2;
    [self.contentView addSubview:_labelTitle];
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ivUserIcon.mas_bottom).offset(6);
        make.left.mas_equalTo(_ivUserIcon);
        make.right.mas_equalTo(_ivCorver.mas_left).offset(-10);
    }];
    //副标题
    _labelSubTitle = [[UILabel alloc] init];
    _labelSubTitle.backgroundColor = [UIColor systemPinkColor];
    [_labelSubTitle setText:@"_labelSubTitle----_labelSubTitle----_labelSubTitle----_labelSubTitle-----_labelSubTitle---_labelSubTitle"];
    _labelSubTitle.numberOfLines = 2;
    [self.contentView addSubview:_labelSubTitle];
    [_labelSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labelTitle.mas_bottom).offset(6);
        make.left.right.mas_equalTo(_labelTitle);
    }];
    //分类
    _labelChapter = [[UILabel alloc] init];
    _labelChapter.backgroundColor = [UIColor blueColor];
    [_labelChapter setText:@"_labelChapter"];
    [self.contentView addSubview:_labelChapter];
    [_labelChapter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ivUserIcon);
        make.top.mas_equalTo(_ivCorver.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    //收藏
    _ivCollect = [[UIImageView alloc] init];
    _ivCollect.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_ivCollect];
    [_ivCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(30);
        make.centerY.mas_equalTo(_labelChapter);
        make.right.mas_equalTo(_labelDate);
    }];
}

- (void)setData:(ArtcleData *)data{
    _data = data;
    [self updateUI:data];
}

- (void)updateUI:(ArtcleData *)data{
    _labelTitle.text = data.title;
}

@end
