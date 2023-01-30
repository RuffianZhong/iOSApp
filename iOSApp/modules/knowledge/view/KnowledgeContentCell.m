//
//  KnowledgeContentCell.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/18.
//

#import "KnowledgeContentCell.h"

@implementation KnowledgeContentCell

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
    _labelTitle = [[UILabel alloc] init];
    _labelTitle.font = kFontText18;
    [self.contentView addSubview:_labelTitle];
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(self.contentView);
        
    }];
    
    _tagView = [[ZTUITagView alloc] initWithWidth:kScreenWidth - 40];
    [self.contentView addSubview:_tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(20);
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.top.mas_equalTo(_labelTitle.mas_bottom).priority(MASLayoutPriorityDefaultHigh);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];

}

- (void)setTitle:(NSString *)title tagArray:(NSArray<NSString*> *)tagArray{
    _title = title;
    _tagArray = tagArray;
    [self updateUI];

}

- (void)updateUI{
    //设置UI数据
    _labelTitle.text = _title;
    [_tagView tagViewDataArray:_tagArray];
}

@end
