//
//  LoginController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/7.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "UITouchScrollView.h"
#import "LoginViewModel.h"

@interface LoginController ()<UITextFieldDelegate>
@property(nonatomic,strong) UITouchScrollView *scrollView;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UIImageView *logoImageView;
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UITextField *accountTextField;
@property(nonatomic,strong) UITextField *pswTextField;
@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) UIButton *pswHidenButton;
@property(nonatomic,strong) UIButton *registerButton;

@property(nonatomic,strong) LoginViewModel *loginViewModel;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataNotify];
    [self initNavigationBar];
    [self initViews];
    [self initData];
}

- (void)initDataNotify{
    _loginViewModel = [[LoginViewModel alloc] init];
    MJWeakSelf
    [self observe:_loginViewModel notify:^(LoginViewModel *observable, NSString * _Nonnull keyPath) {
        if([keyPath isEqualToString:@"account"]){
            [weakSelf updateUI:observable.account];
        }
    }];
}

- (void)initData{
    [_loginViewModel getUserAccount];
}

-(void)updateUI:(NSString*)account{
    if(account){
        _accountTextField.text = account;
    }
}

- (void)initNavigationBar{
    [UIBarHelper navigationBarBackgroundColor:kColorDarkGreen controller:self];
        
    //左侧按钮
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_close"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBarActionBack)];

    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)initViews{
    _scrollView = [[UITouchScrollView alloc] init];
    _scrollView.backgroundColor = kColorWhite;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.view);
        make.left.top.mas_equalTo(self.view);
    }];
    
    [self initHeaderView];
    [self initContentView];
    [self initButtomView];
}

- (void)initHeaderView{
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = kColorDarkGreen;
    [_scrollView addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_scrollView);
        make.height.mas_equalTo(250);
        make.left.top.mas_equalTo(_scrollView);
    }];
    
    _logoImageView = [[UIImageView alloc] init];
    _logoImageView.image = [UIImage imageNamed:@"ic_logo"];
    [_headerView addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headerView.mas_centerY);
        make.centerX.mas_equalTo(_headerView.mas_centerX);
    }];
}

- (void)initContentView{
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = kColorWhite;
    [_contentView zt_cornerWithCornerRadii:4];
    [_contentView zt_shadowWithShadowColor:kColorDarkGreen withShadowRadius:6];
    [_scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.top.mas_equalTo(_headerView.mas_bottom).offset(-50);
    }];
    
    //账号
    _accountTextField = [[UITextField alloc] init];
    [_accountTextField setLeftView:[self textFieldLeftView:@"ic_account"]];
    [_accountTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_accountTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_accountTextField setPlaceholder:L(@"user_name")];
    _accountTextField.returnKeyType = UIReturnKeyNext;
    _accountTextField.delegate = self;
    [_accountTextField addTarget:self action:@selector(textFieldEditingChangedEvent:) forControlEvents:UIControlEventEditingChanged];
    [_contentView addSubview:_accountTextField];
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(_contentView).offset(10);
        make.right.mas_equalTo(_contentView).offset(-10);
        make.top.mas_equalTo(_contentView).offset(10);
    }];
    
    //分割线
    [self addLineViewToSuperView:_contentView withTopView:_accountTextField];

    //密码
    _pswTextField = [[UITextField alloc] init];
    _pswTextField.secureTextEntry = YES;
    [_pswTextField setLeftView:[self textFieldLeftView:@"ic_password"]];
    [_pswTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_pswTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_pswTextField setPlaceholder:L(@"user_psw")];
    _pswTextField.delegate = self;
    _pswTextField.returnKeyType = UIReturnKeyDone;
    [_pswTextField addTarget:self action:@selector(textFieldEditingChangedEvent:) forControlEvents:UIControlEventEditingChanged];
    [_contentView addSubview:_pswTextField];
    [_pswTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(_accountTextField);
        make.right.mas_equalTo(_accountTextField).offset(-30);
        make.top.mas_equalTo(_accountTextField.mas_bottom).offset(10);
    }];
    
    //分割线
    [self addLineViewToSuperView:_contentView withTopView:_pswTextField];

    //密码显示-隐藏
    _pswHidenButton = [UIButton new];
    _pswHidenButton.backgroundColor = [UIColor redColor];
    [_pswHidenButton setImage:[UIImage imageNamed:@"ic_show"] forState:UIControlStateNormal];//默认图片
    [_pswHidenButton setImage:[UIImage imageNamed:@"ic_hide"] forState:UIControlStateSelected];//选中图片
    [_pswHidenButton addTarget:self action:@selector(buttonClickEvent:)forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_pswHidenButton];
    [_pswHidenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_pswTextField.mas_centerY);
        make.right.mas_equalTo(_accountTextField.mas_right);
    }];
    
    //登录按钮
    _loginButton = [[UIButton alloc] init];
    _loginButton.enabled = NO;
    [_loginButton setTitle:L(@"login") forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage imageWithSize:CGSizeMake(50,100) color:[UIColor grayColor] cornerRadius:0] forState:UIControlStateDisabled];
    [_loginButton setBackgroundImage:[UIImage imageWithSize:CGSizeMake(50,100) color:kColorGreen cornerRadius:0] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton zt_cornerWithCornerRadii:50];
    [_contentView addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(_pswTextField.mas_bottom).offset(40);
        make.left.right.mas_equalTo(_accountTextField);
        make.bottom.mas_equalTo(_contentView.mas_bottom).offset(-40);
    }];
}

- (UIView*)textFieldLeftView:(NSString*)imageName{
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [leftView setContentMode:UIViewContentModeCenter];
    [leftView setFrame:CGRectMake(10, 0, 60, 24)];
    return leftView;
}

- (void)addLineViewToSuperView:(UIView *)superView withTopView:(UIView*)topView{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    [superView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.mas_equalTo(superView).offset(10);
        make.right.mas_equalTo(superView).offset(-10);
    }];
}

- (void)initButtomView{
    NSString *noAccountStr = L(@"no_account");
    NSString *registerNowStr = L(@"register_now");
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:
                                                 [NSString stringWithFormat:@"%@%@",noAccountStr,registerNowStr]];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorDarkGreen
                       range:NSMakeRange(noAccountStr.length, registerNowStr.length)];

    _registerButton = [[UIButton alloc] init];
    [_registerButton setAttributedTitle:attrString forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(_scrollView.mas_centerX);
        make.bottom.mas_equalTo(_scrollView.mas_bottom).offset(-80);
    }];
}

- (void)buttonClickEvent:(UIButton*)button{
    if(button == self.pswHidenButton){
        self.pswHidenButton.selected = !button.isSelected;
        self.pswTextField.secureTextEntry = !button.isSelected;
    }else if(button == self.loginButton){
        NSString *pswText = self.pswTextField.text;
        NSString *accountText = self.accountTextField.text;
        
        [HUDUtils showLoadingForView:self.view];
        [_loginViewModel loginWithAccount:accountText password:pswText success:^(UserData * _Nonnull data) {
            [HUDUtils hideLoadingForView:self.view];

            [HUDUtils showToastMsg:L(@"login_success") forView:self.view];
            
            if(self.loginResultBlock) self.loginResultBlock(self.loginViewModel.userData);

            [self.navigationController popViewControllerAnimated:YES];

        } error:^(NSNumber * _Nonnull code, NSString * _Nonnull msg) {
            [HUDUtils hideLoadingForView:self.view];

            [HUDUtils showToastMsg:msg forView:self.view];
        }];
        
    }else if(button == self.registerButton){
        RegisterController *controller = [[RegisterController alloc] init];
        controller.registerResultBlock = ^(NSString * _Nonnull account) {
            self.loginViewModel.account = account;
        };
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)navigationBarActionBack{
//    [HUDUtils showToastMsg:L(@"login_success") forView:self.view];

    
    [self.navigationController popViewControllerAnimated:YES];
}

// 点击空白处收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [KeyboardUtils hidenKeyboard];
}

#pragma mark -UITextFieldDelegate
//return按钮事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.accountTextField){
        [self.pswTextField becomeFirstResponder];
    }else if(textField == self.pswTextField){
        [KeyboardUtils hidenKeyboard];
    }
    return YES;
}

//监听 UITextField 内容变化
-(void)textFieldEditingChangedEvent:(UITextField*)textField{
    NSString *pswText = self.pswTextField.text;
    NSString *accountText = self.accountTextField.text;
    BOOL canSubmit = pswText.length > 0 && accountText.length > 0;
    self.loginButton.enabled = canSubmit;
}

@end
