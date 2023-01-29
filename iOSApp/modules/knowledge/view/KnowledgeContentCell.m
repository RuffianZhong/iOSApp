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
        self.backgroundColor = [UIColor purpleColor];
        [self initViews];
    }
    return self;
}

- (void)initViews{
    _labelTitle = [[UILabel alloc] init];
    _labelTitle.backgroundColor = [UIColor greenColor];
    _labelTitle.font = kFontText18;
    [self addSubview:_labelTitle];
 
    
    _tagView = [[ZTUITagView alloc] initWithWidth:kScreenWidth - 40];
    _tagView.backgroundColor = [UIColor redColor];
    [self addSubview:_tagView];
    
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(self);
        make.left.top.mas_equalTo(self);
    }];


    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(_labelTitle.mas_bottom).offset(20).priority(MASLayoutPriorityDefaultHigh);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
    }];

}

- (void)setTitle:(NSString *)title tagArray:(NSMutableArray<NSString*> *)tagArray{
    _title = title;
    _tagArray = tagArray;
    [self updateUI];

}

- (void)updateUI{
    //设置UI数据
    _labelTitle.text = _title;
    [_tagView tagViewDataArray:_tagArray];
//    [_tagView tagViewWidth:kScreenWidth - 40];

    
//    [_tagView setFrame:CGRectMake(20, 60, kScreenWidth - 40, 100)];
    
}


@end
