//
//  ArticleDetailsController.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/1.
//

#import "ArticleDetailsController.h"

@interface ArticleDetailsController ()<WKNavigationDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) WKWebView *webView;
@property(nonatomic,strong) UIProgressView *progressView;

@property(nonatomic) CGFloat progress;
@end

@implementation ArticleDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initWebView];
    [self initProgressView];
}

- (void)initWebView{
//    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    _webView = [[WKWebView alloc] init];
    _webView.backgroundColor = kColorWhite;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationBarView.mas_bottom);
    }];
    //添加进度监听
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

    
    //加载页面内容
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_articleData.link]];
    [_webView loadRequest:request];
}

- (void)initProgressView{
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    _progressView.progressTintColor = kColorDarkGreen;
    _progressView.trackTintColor = [UIColor grayColor];
    [self.view addSubview:_progressView];
}


- (void)initNavigationBar{
    CGFloat itemWidth = 44.f;
    CGFloat itemHeight = 44.f;

    UIButton *browseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, itemWidth, itemHeight)];
    [browseButton setImage:[UIImage imageNamed:@"ic_language"] forState:UIControlStateNormal];
    [browseButton addTarget:self action:@selector(navigationBarActionBrowse) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *collectButton = [[UIButton alloc] initWithFrame:CGRectMake(itemWidth, 0, itemWidth, itemHeight)];
    [collectButton setImage:[UIImage imageNamed:@"ic_collect_no"] forState:UIControlStateNormal];
    [collectButton addTarget:self action:@selector(navigationBarActionCollect) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemWidth * 2, itemHeight)];
    [rightView addSubview:browseButton];
    [rightView addSubview:collectButton];
    
    [self setNavigationTitle:self.articleData.title];
    [self.navigationBarView setCustomRightBarView:rightView];
}

- (void)navigationBarActionBrowse{
    
}

- (void)navigationBarActionCollect{
    
}

//监听 WebView 加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"estimatedProgress"]){
        self.progressView.progress = self.webView.estimatedProgress;
    }
}

#pragma mark -WKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _progressView.hidden = NO;
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    _progressView.hidden = YES;
    
    [self computeProgressForScrollerView:webView.scrollView withOffset:1];
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self computeProgressForScrollerView:scrollView withOffset:scrollView.contentOffset.y];
}

- (void)computeProgressForScrollerView:(UIScrollView*)scrollView withOffset:(CGFloat)scrolledOffset{
    
    //当前滚动偏移量
//    CGFloat scrolledOffset = scrollView.contentOffset.y;
    
    //总体可滚动偏移量
    CGFloat totalOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    CGFloat tempProgress = scrolledOffset / totalOffset;
    
    //此处业务逻辑：进度只有不断增大
    if(tempProgress > _progress){
        tempProgress = tempProgress > 1 ? 1 : tempProgress;//上拉“溢出”导致数值超过1
        _progress = tempProgress;
    }
}

//页面反向传值：通过Block传值
- (void)viewDidDisappear:(BOOL)animated{
    if(_progressUpdateBlock){
        _progressUpdateBlock(_progress);
    }
}

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    _webView.navigationDelegate = nil;
}
@end
