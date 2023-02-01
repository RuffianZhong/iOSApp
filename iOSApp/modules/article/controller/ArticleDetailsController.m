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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initNavigationBar];
    [self initWebView];
    [self initProgressView];
}

- (void)initWebView{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 600)];//self.view.frame
    _webView.backgroundColor = kColorWhite;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
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
    [UIBarHelper navigationBarBackgroundColor:kColorDarkGreen controller:self];
    
    self.navigationItem.title = _articleData.title;
    
    //右侧按钮
    UIBarButtonItem *browseButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_tab_home"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBarActionBrowse)];
    
    UIBarButtonItem *collectButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_tab_home"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBarActionCollect)];

    self.navigationItem.rightBarButtonItems = @[browseButtonItem,collectButtonItem];

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
    if(tempProgress > _progress) _progress = tempProgress;
}


- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    _webView.navigationDelegate = nil;
}
@end
