//
//  ArtcleCell.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import "ArticleCell.h"
#import "ArticleData.h"

@implementation ArticleCell

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
    [_ivUserIcon zt_cornerWithCornerRadii:20];
    [self.contentView addSubview:_ivUserIcon];
    [_ivUserIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(40);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.contentView).offset(10);
    }];
    //昵称
    _labelUserName = [[UILabel alloc] init];
    [_labelUserName setText:L(@"placeholder")];
    [self.contentView addSubview:_labelUserName];
    [_labelUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_ivUserIcon);
        make.left.mas_equalTo(_ivUserIcon.mas_right).offset(6);
    }];
    //日期
    _labelDate = [[UILabel alloc] init];
    [_labelDate setText:L(@"placeholder")];
    [self.contentView addSubview:_labelDate];
    [_labelDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.centerY.mas_equalTo(_ivUserIcon);
    }];
    //封面
    _ivCorver = [[UIImageView alloc] init];
    ///按比例缩放到View 宽高，可能超出部分，使用 .clipsToBounds = YES 裁剪掉
    [_ivCorver setContentMode:UIViewContentModeScaleAspectFill];
    _ivCorver.clipsToBounds = YES;
    [self.contentView addSubview:_ivCorver];
    [_ivCorver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(100);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(_ivUserIcon.mas_bottom).offset(6);
    }];
    //主标题
    _labelTitle = [[UILabel alloc] init];
    [_labelTitle setText:L(@"placeholder")];
    _labelTitle.numberOfLines = 2;
    [self.contentView addSubview:_labelTitle];
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ivUserIcon.mas_bottom).offset(6);
        make.left.mas_equalTo(_ivUserIcon);
        make.right.mas_equalTo(_ivCorver.mas_left).offset(-10);
    }];
    //副标题
    _labelSubTitle = [[UILabel alloc] init];
    [_labelSubTitle setText:L(@"placeholder")];
    _labelSubTitle.numberOfLines = 2;
    [self.contentView addSubview:_labelSubTitle];
    [_labelSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labelTitle.mas_bottom).offset(6);
        make.left.right.mas_equalTo(_labelTitle);
    }];
    //分类
    _labelChapter = [[UILabel alloc] init];
    [_labelChapter setText:L(@"placeholder")];
    [self.contentView addSubview:_labelChapter];
    [_labelChapter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ivUserIcon);
        make.top.mas_equalTo(_ivCorver.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    //收藏
    _ivCollect = [[UIImageView alloc] init];
    _ivCollect.image = [UIImage imageNamed:@"ic_tab_home"];
    [self.contentView addSubview:_ivCollect];
    [_ivCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(30);
        make.centerY.mas_equalTo(_labelChapter);
        make.right.mas_equalTo(_labelDate);
    }];
}

- (void)setData:(ArticleData *)data{
    _data = data;
    [self updateUI:data];
}

- (void)updateUI:(ArticleData *)data{
    //设置UI数据
    [_ivUserIcon setImageWithURL:data.userIcon];
    _labelUserName.text = data.userName;
    _labelDate.text = data.date;
    _labelTitle.text = data.title;
    _labelSubTitle.text = data.desc;
    [_ivCorver setImageWithURL:data.cover];
    _labelChapter.text = [NSString stringWithFormat:L(@"label_group"), data.superChapterName,data.chapterName];
    
    //控件展示逻辑：1.隐藏的控件大小设置为0，对应的约束保留；2.remakeConstraints
    //封面
    [_ivCorver mas_remakeConstraints:^(MASConstraintMaker *make) {
        if(data.cover.length > 0){
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(100);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
            make.top.mas_equalTo(_ivUserIcon.mas_bottom).offset(6);
        }else{
            make.width.height.mas_equalTo(0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(_ivUserIcon.mas_bottom);
        }
    }];

    //副标题
    [_labelSubTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        if(data.desc.length > 0){
            make.top.mas_equalTo(_labelTitle.mas_bottom).offset(6);
            make.left.right.mas_equalTo(_labelTitle);
        }else{
            make.height.width.mas_equalTo(0);
            make.top.mas_equalTo(_labelTitle.mas_bottom);
        }
    }];
    
    //分类：有封面在封面底部，没封面在副标题底部（封面约束是存在的）
    [_labelChapter mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        if(data.cover.length > 0){
            make.top.mas_equalTo(_ivCorver.mas_bottom).offset(10);
        }else{
            make.top.mas_equalTo(_labelSubTitle.mas_bottom).offset(10);
        }
        make.left.mas_equalTo(_ivUserIcon);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
}

@end
