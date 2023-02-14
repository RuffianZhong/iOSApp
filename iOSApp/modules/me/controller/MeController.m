//
//  MeController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "MeController.h"
#import "MeViewModel.h"
#import "LoginController.h"
#import "CollectController.h"

@interface MeController ()
@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UIImageView *ivUserIcon;
@property(nonatomic,strong) UILabel *labelUserName;
@property(nonatomic,strong) UILabel *labelUserIntegral;

@property(nonatomic,strong) UIView *viewCollect;
@property(nonatomic,strong) UIButton *btnCollect;
@property(nonatomic,strong) UIImageView *ivCollectNext;

@property(nonatomic,strong) UIView *viewLanguage;
@property(nonatomic,strong) UIButton *btnLanguage;
@property(nonatomic,strong) UIImageView *ivLanguageNext;
@property(nonatomic,strong) UIButton *btnLanguageChinese;
@property(nonatomic,strong) UIButton *btnLanguageEnglish;

@property(nonatomic) BOOL languageContentOpen;

@property(nonatomic,strong) MeViewModel *meViewModel;

@end

@implementation MeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationLeftImage:[UIImage new]];
    
    [self initDataNotify];
    [self initScrollView];
    [self initHeaderView];
    [self initCollectView];
    [self initLanguageView];
    [self initData];
}

- (void)dealloc{
    [_meViewModel removeObserver:self forKeyPath:@"userData" context:nil];
}

- (void)initData{
    [_meViewModel getUserDataFromLocal];
}

- (void)initDataNotify{
    _meViewModel = [[MeViewModel alloc] init];
    WeakSelf
    [self observe:_meViewModel notify:^(MeViewModel *observable, NSString *keyPath) {
        [weakSelf updateUI:observable keyPath:keyPath];
    }];
}

-(void)updateUI:(MeViewModel *)viewModel keyPath:(NSString*) keyPath{
    
    if(viewModel.userData){
        [self updateNavigationItem:YES];
        
        [_ivUserIcon setImageWithURL:viewModel.userData.icon];
        [_labelUserName setText:viewModel.userData.nickname];
        [_labelUserIntegral setHidden:NO];
        [_labelUserIntegral setText:[NSString stringWithFormat:L(@"integral"), viewModel.userData.coinCount]];
        
    }else{
        [self updateNavigationItem:NO];
    
        [_ivUserIcon setImage:[UIImage imageNamed:@"ic_logo"]];
        [_labelUserName setText:L(@"login")];
        [_labelUserIntegral setHidden:YES];
    }
}

- (void)updateNavigationItem:(BOOL)isLogin{
    if(isLogin){
        [self setNavigationRightImage:[UIImage imageNamed:@"ic_logout"]];
        WeakSelf
        [self setNavigationRightBarHandler:^(NSInteger index) {
            [weakSelf.meViewModel logout];
        }];
    }else{
        [self setNavigationRightImage:[UIImage new]];
        [self setNavigationRightBarHandler:nil];
    }
   
}

- (void)initScrollView{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
    }];
}

- (void)initHeaderView{
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = kColorDarkGreen;
    [_headerView zt_gradientWithGradientColors:@[kColorDarkGreen,kColorDarkGreen] withDirection:GradientDirectionTop2Bottom];
    [self.scrollView addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_scrollView.mas_width);
        make.left.top.mas_equalTo(_scrollView);
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconAction)];
    _ivUserIcon = [[UIImageView alloc] init];
    [_ivUserIcon setContentMode:UIViewContentModeScaleAspectFill];
    [_ivUserIcon zt_cornerWithCornerRadii:50];
    //添加点击事件
    _ivUserIcon.userInteractionEnabled = YES;
    [_ivUserIcon addGestureRecognizer:tapGesture];
    [_headerView addSubview:_ivUserIcon];
    [_ivUserIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(90);
        make.centerX.mas_equalTo(_headerView.mas_centerX);
        make.top.mas_equalTo(_headerView.mas_top);
    }];
    
    _labelUserName = [[UILabel alloc] init];
    [_labelUserName setTextColor:kColorWhite];
    [_headerView addSubview:_labelUserName];
    [_labelUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headerView.mas_centerX);
        make.top.mas_equalTo(_ivUserIcon.mas_bottom).offset(20);
    }];
    
    _labelUserIntegral = [[UILabel alloc] init];
    [_labelUserIntegral setTextColor:kColorWhite];
    [_headerView addSubview:_labelUserIntegral];
    [_labelUserIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headerView.mas_centerX);
        make.top.mas_equalTo(_labelUserName.mas_bottom).offset(20);
        make.bottom.mas_equalTo(_headerView.mas_bottom).offset(-30);
    }];
}

- (void)initCollectView{
        
    _viewCollect = [[UIView alloc] init];
    [_scrollView addSubview:_viewCollect];
    [_viewCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(_scrollView);
        make.top.mas_equalTo(_headerView.mas_bottom);
    }];
    
    _btnCollect = [[UIButton alloc] init];
    _btnCollect.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;//文本和图标的布局
    [_btnCollect setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];//图片与文本之间的间距：设置文本内间距
    [_btnCollect setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];//按钮整体内边距
    [_btnCollect setTitleColor:kColorBlack forState:UIControlStateNormal];
    [_btnCollect setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_btnCollect setTitle:L(@"collect") forState:UIControlStateNormal];
    [_btnCollect setImage:[UIImage imageNamed:@"ic_collect_normal"] forState:UIControlStateNormal];
    [_btnCollect addTarget:self action:@selector(collectActionLogic:) forControlEvents:UIControlEventTouchUpInside];
    [_viewCollect addSubview:_btnCollect];
    [_btnCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(_viewCollect);
    }];
    
    _ivCollectNext = [[UIImageView alloc] init];
    _ivCollectNext.image = [UIImage imageNamed:@"ic_right"];
    [_viewCollect addSubview:_ivCollectNext];
    [_ivCollectNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_viewCollect);
        make.right.mas_equalTo(_viewCollect.mas_right).offset(-20);
    }];
    
}

- (void)initLanguageView{
    Language language = [AppDelegate shareAppDelegate].language;
    CGFloat height = 60;//60 + 50 +50;
    _viewLanguage = [[UIView alloc] init];
    [_viewLanguage layer].masksToBounds = YES;
    [_scrollView addSubview:_viewLanguage];
    [_viewLanguage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_scrollView);
        make.height.mas_equalTo(height);
        make.top.mas_equalTo(_viewCollect.mas_bottom);
    }];
    
    UIView *viewSplitTop = [[UIView alloc] init];
    viewSplitTop.backgroundColor = [UIColor grayColor];
    [_viewLanguage addSubview:viewSplitTop];
    [viewSplitTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_viewLanguage);
        make.height.mas_equalTo(0.2f);
        make.top.mas_equalTo(_viewLanguage);
    }];
    
    UIView *viewSplitBottom = [[UIView alloc] init];
    viewSplitBottom.backgroundColor = [UIColor grayColor];
    [_viewLanguage addSubview:viewSplitBottom];
    [viewSplitBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_viewLanguage);
        make.height.mas_equalTo(0.2f);
        make.bottom.mas_equalTo(_viewLanguage);
    }];
    
    _btnLanguage = [[UIButton alloc] init];
    [_btnLanguage setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [_btnLanguage setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];//图片与文本之间的间距：设置文本内间距
    [_btnLanguage setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_btnLanguage setTitle:L(@"multi_language") forState:UIControlStateNormal];
    [_btnLanguage setTitleColor:kColorBlack forState:UIControlStateNormal];
    [_btnLanguage setImage:[UIImage imageNamed:@"ic_language"] forState:UIControlStateNormal];
    [_btnLanguage addTarget:self action:@selector(languageActionLogic:) forControlEvents:UIControlEventTouchUpInside];
    [_viewLanguage addSubview:_btnLanguage];
    [_btnLanguage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(_viewLanguage);
        make.left.mas_equalTo(_viewLanguage);
        make.top.mas_equalTo(_viewLanguage);
    }];
    
    _ivLanguageNext = [[UIImageView alloc] init];
    _ivLanguageNext.image = [UIImage imageNamed:@"ic_down"];
    [_viewLanguage addSubview:_ivLanguageNext];
    [_ivLanguageNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(_btnLanguage);
        make.right.mas_equalTo(_viewLanguage.mas_right).offset(-20);
    }];
    
    _btnLanguageChinese = [[UIButton alloc] init];
    [_btnLanguageChinese setTitleColor:kColorBlack forState:UIControlStateNormal];
    [_btnLanguageChinese setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_btnLanguageChinese setTitle:L(@"language_chinese") forState:UIControlStateNormal];
    [_btnLanguageChinese setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_btnLanguageChinese setImage:[UIImage imageNamed:@"ic_select_no"] forState:UIControlStateNormal];
    [_btnLanguageChinese setImage:[UIImage imageNamed:@"ic_select"] forState:UIControlStateSelected];
    [_btnLanguageChinese addTarget:self action:@selector(languageChildActionLogic:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLanguageChinese setSelected:[language isEqualToString:Language_zh]];
    [_viewLanguage addSubview:_btnLanguageChinese];
    [_btnLanguageChinese mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(_viewLanguage);
        make.left.mas_equalTo(_btnLanguage.mas_left).offset(40);
        make.top.mas_equalTo(_btnLanguage.mas_bottom);
    }];
    
    _btnLanguageEnglish = [[UIButton alloc] init];
    [_btnLanguageEnglish setTitleColor:kColorBlack forState:UIControlStateNormal];
    [_btnLanguageEnglish setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_btnLanguageEnglish setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_btnLanguageEnglish setImage:[UIImage imageNamed:@"ic_select_no"] forState:UIControlStateNormal];
    [_btnLanguageEnglish setImage:[UIImage imageNamed:@"ic_select"] forState:UIControlStateSelected];
    [_btnLanguageEnglish addTarget:self action:@selector(languageChildActionLogic:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLanguageEnglish setTitle:L(@"language_english") forState:UIControlStateNormal];
    [_btnLanguageEnglish setSelected: [language isEqualToString:Language_en]];
    [_viewLanguage addSubview:_btnLanguageEnglish];
    [_btnLanguageEnglish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(_viewLanguage);
        make.left.mas_equalTo(_btnLanguageChinese);
        make.top.mas_equalTo(_btnLanguageChinese.mas_bottom);
    }];
    
}

#pragma mark - 事件/逻辑

- (void)userIconAction{
    if(!_meViewModel.userData){
        [self gotoLoginController];
    }
}

- (void)languageActionLogic:(UIButton *)button{
   
    [_viewLanguage mas_remakeConstraints:^(MASConstraintMaker *make) {
        if(!_languageContentOpen){
            make.height.mas_equalTo(160);
        }else{
            make.height.mas_equalTo(60);
        }
        make.width.mas_equalTo(_scrollView);
        make.top.mas_equalTo(_viewCollect.mas_bottom);
    }];
    _ivLanguageNext.image = _languageContentOpen ? [UIImage imageNamed:@"ic_down"] : [UIImage imageNamed:@"ic_up"];

    //赋值
    _languageContentOpen = !_languageContentOpen;
}

- (void)languageChildActionLogic:(UIButton *)button{
    [_btnLanguageChinese setSelected:button == _btnLanguageChinese];
    [_btnLanguageEnglish setSelected:button == _btnLanguageEnglish];
    
    Language language;
    if(button == _btnLanguageChinese){
        language = Language_zh;
    }else if(button == _btnLanguageEnglish){
        language = Language_en;
    }
    
    [[AppDelegate shareAppDelegate] setAppLanguage:language];
}

- (void)collectActionLogic:(UIButton *)button{
    if(!_meViewModel.userData){
        [self gotoLoginController];
    }else{
        CollectController *controller = [[CollectController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)gotoLoginController{
    LoginController *controller = [[LoginController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    WeakSelf
    controller.loginResultBlock = ^(UserData * _Nonnull userData) {
        if(userData){
            weakSelf.meViewModel.userData = userData;
        }
    };
    
    BaseUINavigationController *parentController = [[BaseUINavigationController alloc] init];
    [parentController pushViewController:controller animated:NO];
    parentController.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    parentController.modalPresentationCapturesStatusBarAppearance = YES;
    
    [self.navigationController presentViewController:parentController animated:YES completion:nil];
}

@end
