//
//  BookHeaderView.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import "BookHeaderView.h"


@interface BookHeaderView()

@property(nonatomic,strong) UIImageView *ivCover;
@property(nonatomic,strong) UILabel *labelName;
@property(nonatomic,strong) UILabel *labelAuthor;
@property(nonatomic,strong) UILabel *labelDese;//简介
@property(nonatomic,strong) UILabel *labelLisense;

@end

@implementation BookHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //自定义子控件初始化逻辑
        [self initViews];
        self.backgroundColor = kColorDarkGreen;
    }
    return self;
}

- (void)initViews{
    //封面
    _ivCover = [[UIImageView alloc] init];
    _ivCover.contentMode = UIViewContentModeScaleAspectFill;
    _ivCover.clipsToBounds = YES;
    [self addSubview:_ivCover];
    [_ivCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(110);
        make.left.mas_equalTo(self).offset(40);
        make.top.mas_equalTo(self).offset(10);
    }];
    
    //名称
    _labelName = [[UILabel alloc] init];
    _labelName.font = kFontText16;
    _labelName.textColor = kColorWhite;
    [self addSubview:_labelName];
    [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ivCover.mas_right).offset(10);
        make.top.mas_equalTo(_ivCover.mas_top);
        make.right.mas_equalTo(self).offset(-20);
    }];
    
    //作者
    _labelAuthor = [[UILabel alloc] init];
    _labelAuthor.font = kFontText14;
    _labelAuthor.textColor = kColorWhite;
    [self addSubview:_labelAuthor];
    [_labelAuthor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_labelName);
        make.top.mas_equalTo(_labelName.mas_bottom).offset(10);
        make.right.mas_equalTo(_labelName.mas_right);
    }];
    
    //简介
    _labelDese = [[UILabel alloc] init];
    _labelDese.font = kFontText14;
    [self addSubview:_labelDese];
    [_labelDese mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_labelName);
        make.top.mas_equalTo(_labelAuthor.mas_bottom).offset(10);
        make.right.mas_equalTo(_labelName.mas_right);
    }];
    
    //版权
    _labelLisense = [[UILabel alloc] init];
    _labelLisense.font = kFontText14;
    [self addSubview:_labelLisense];
    [_labelLisense mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ivCover);
        make.top.mas_equalTo(_ivCover.mas_bottom).offset(10);
        make.right.mas_equalTo(self).offset(-20);
        make.bottom.mas_equalTo(self).offset(-10);
    }];
    
    _ivCover.backgroundColor = [UIColor redColor];
    _labelName.backgroundColor = [UIColor redColor];
    _labelAuthor.backgroundColor = [UIColor redColor];
    _labelDese.backgroundColor = [UIColor redColor];
    _labelLisense.backgroundColor = [UIColor redColor];

}

- (void)setBookData:(BookData *)bookData{
    _bookData = bookData;
    
    [_ivCover setImageWithURL:bookData.cover];
    _labelName.text = bookData.name;
    _labelAuthor.text = bookData.author;
    _labelDese.text = bookData.desc;
    _labelLisense.text = bookData.lisense;
}

@end
