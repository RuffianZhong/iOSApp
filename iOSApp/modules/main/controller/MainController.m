//
//  MainController.m
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/29.
//

#import "MainController.h"
#import "HomeController.h"
#import "ProjectController.h"
#import "BookController.h"
#import "KnowledgeController.h"
#import "MeController.h"
#import "BaseUINavigationController.h"


@interface MainController ()

@property(nonatomic,strong) BaseUINavigationController *homeNavCtl;
@property(nonatomic,strong) BaseUINavigationController *projectNavCtl;
@property(nonatomic,strong) BaseUINavigationController *bookNavCtl;
@property(nonatomic,strong) BaseUINavigationController *knowledgeNavCtl;
@property(nonatomic,strong) BaseUINavigationController *meNavCtl;

@property(nonatomic,strong) HomeController *homeCtl;
@property(nonatomic,strong) ProjectController *projectCtl;
@property(nonatomic,strong) BookController *bookCtl;
@property(nonatomic,strong) KnowledgeController *knowledgeCtl;
@property(nonatomic,strong) MeController *meCtl;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBarController];
}

-(void)initTabBarController{
      
    //home
    _homeCtl = [[HomeController alloc] init];
    _homeNavCtl = [[BaseUINavigationController alloc] initWithRootViewController:_homeCtl];

    
    //project
    _projectCtl = [[ProjectController alloc] init];
    _projectNavCtl =[[BaseUINavigationController alloc] initWithRootViewController:_projectCtl];
       
    //book
    _bookCtl = [[BookController alloc] init];
    _bookNavCtl = [[BaseUINavigationController alloc] initWithRootViewController:_bookCtl];
      
    
    //knowledge
    _knowledgeCtl = [[KnowledgeController alloc] init];
    _knowledgeNavCtl = [[BaseUINavigationController alloc] initWithRootViewController:_knowledgeCtl];
    
    // me
    _meCtl = [[MeController alloc] init];
    _meNavCtl = [[BaseUINavigationController alloc] initWithRootViewController:_meCtl];
    
    [self setTabBarItems];
           
    [self addChildViewController:_homeNavCtl];
    [self addChildViewController:_projectNavCtl];
    [self addChildViewController:_bookNavCtl];
    [self addChildViewController:_knowledgeNavCtl];
    [self addChildViewController:_meNavCtl];
    
    self.selectedIndex = 0;
}


-(void)initTabBarItem:(UINavigationController *) controller title:(NSString *)title imageName:(NSString *)imageName{
    //UITabBar 背景颜色
    UIColor *colorBG = [SystemUtils isDarkAppearance] ? kColorDarkGrey : kColorWhite;
    UIColor *normalColor = [SystemUtils isDarkAppearance] ? kColorDarkWhite : [UIColor grayColor];
    UIColor *selectedColor = kColorDarkGreen;
    
    UIImage *normalImage =
    [[[UIImage imageNamed:imageName]
                imageWithColor:normalColor]
                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage =
    [[[UIImage imageNamed:imageName]
                imageWithColor:selectedColor]
                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabBarItem = controller.tabBarItem;
    tabBarItem.title = title;
    tabBarItem.image = normalImage;
    tabBarItem.selectedImage = selectedImage;
    
    
    if (@available(iOS 13.0, *)) {
        
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        UITabBarItemAppearance *itemAppearance = [[UITabBarItemAppearance alloc] init];

        [itemAppearance.normal setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor}];
        [itemAppearance.selected setTitleTextAttributes:@{NSForegroundColorAttributeName:selectedColor}];

        appearance.stackedLayoutAppearance = itemAppearance;
        appearance.backgroundColor = colorBG;
        
        self.tabBar.standardAppearance = appearance;
    } else {
        
        [tabBarItem  setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor}
                                   forState:UIControlStateNormal];
        [tabBarItem  setTitleTextAttributes:@{NSForegroundColorAttributeName:selectedColor}
                                   forState:UIControlStateSelected];

        [UIBarHelper tabBarBackgroundColor:self.tabBar color:colorBG];
    }
    controller.tabBarItem = tabBarItem;

}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        //（暗黑模式）模式变化
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            [self setTabBarItems];
        }
    }
}

- (void)setTabBarItems{
    [self initTabBarItem:_homeNavCtl title:L(@"tab_home") imageName:@"ic_tab_home"];
    [self initTabBarItem:_projectNavCtl title:L(@"tab_project") imageName:@"ic_tab_project"];
    [self initTabBarItem:_bookNavCtl title:L(@"tab_book") imageName:@"ic_tab_book"];
    [self initTabBarItem:_knowledgeNavCtl title:L(@"tab_knowledge") imageName:@"ic_tab_knowledge"];
    [self initTabBarItem:_meNavCtl title:L(@"tab_me") imageName:@"ic_tab_me"];
}

@end
