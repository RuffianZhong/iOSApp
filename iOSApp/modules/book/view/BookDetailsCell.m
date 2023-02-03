//
//  BookDetailsCell.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import "BookDetailsCell.h"
#import "DateUtils.h"

@implementation BookDetailsCell

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
    //标题
    _labelTitle = [[UILabel alloc] init];
    _labelTitle.font = kFontText18;
    [self.contentView addSubview:_labelTitle];
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.right.mas_equalTo(self.contentView).offset(-20);
    }];
    
    //学习进度文本
    _labelProgress = [[UILabel alloc] init];
    _labelProgress.font = kFontText14;
    _labelProgress.textColor = kColorDarkGreen;
    [self.contentView addSubview:_labelProgress];
    [_labelProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labelTitle.mas_bottom).offset(6);
        make.left.mas_equalTo(_labelTitle.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    //日期
    _labelDate = [[UILabel alloc] init];
    _labelDate.font = kFontText12;
    _labelDate.textColor = [UIColor grayColor];
    [self.contentView addSubview:_labelDate];
    [_labelDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_labelProgress.mas_centerY);
        make.right.mas_equalTo(_labelTitle.mas_right);
    }];
    
    //学习进度
    _progressView = [[UIProgressView alloc] init];
    _progressView.progressTintColor = kColorDarkGreen;
    _progressView.trackTintColor = [UIColor grayColor];
    [self.contentView addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(6);
        make.centerY.mas_equalTo(_labelProgress.mas_centerY);
        make.left.mas_equalTo(_labelProgress.mas_right).offset(4);
        make.right.mas_equalTo(_labelDate.mas_left).offset(-4);
    }];
}

- (void)setArticleData:(ArticleData *)articleData{
    _articleData = articleData;
    _labelTitle.text = articleData.title;

    StudyData *studyData = articleData.studyData;
    if(studyData){
        _labelDate.hidden = NO;
        _progressView.hidden = NO;
        _progressView.progress = studyData.progress;
        NSString *string = [NSString stringWithFormat:@"%.0f", studyData.progress * 100];
        _labelProgress.text = [NSString stringWithFormat:L(@"learn_progress"), string];
        _labelDate.text = [DateUtils formatDateWithSecond: studyData.time];
    }else{
        _labelDate.hidden = YES;
        _progressView.hidden = YES;
        _progressView.progress = 0.f;
        _labelProgress.text = L(@"learn_no");
        _labelDate.text = @"";
    }
    
}




@end
