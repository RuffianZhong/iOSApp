//
//  HomeController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "HomeController.h"

@interface HomeController ()
@property(nonatomic,strong) UIImageView *image;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _image = [[UIImageView alloc] init];
    
    [self.view addSubview:_image];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(50);
        make.top.mas_equalTo(self.view.mas_top).offset(150);
        make.left.mas_equalTo(self.view.mas_left).offset(50);
    }];
    
    UIImage *image = [UIImage imageNamed:@"ic_tab_home"];
    [image imageWithTint:[UIColor redColor]];
    [_image setImage:image];
    
    
}


@end
