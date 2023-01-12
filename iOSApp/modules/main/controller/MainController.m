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
    
//    [UIBarHelper tabBarBackgroundColor:self.tabBar color:kColorDarkGreen];
    
    //home
    _homeCtl = [[HomeController alloc] init];
    _homeNavCtl = [[BaseUINavigationController alloc] initWithRootViewController:_homeCtl];
    [self initTabBarItem:_homeNavCtl setTitle:L(@"tab_home") setNormalImage:@"ic_tab_home" setSelectedImage:@"ic_tab_home"];

    
    //project
    _projectCtl = [[ProjectController alloc] init];
    _projectNavCtl =[[BaseUINavigationController alloc] initWithRootViewController:_projectCtl];
    [self initTabBarItem:_projectNavCtl setTitle:L(@"tab_project") setNormalImage:@"ic_tab_project" setSelectedImage:@"ic_tab_project"];
       
    //book
    _bookCtl = [[BookController alloc] init];
    _bookNavCtl = [[BaseUINavigationController alloc] initWithRootViewController:_bookCtl];
    [self initTabBarItem:_bookNavCtl setTitle:L(@"tab_book") setNormalImage:@"ic_tab_book" setSelectedImage:@"ic_tab_book"];
       
    
    //knowledge
    _knowledgeCtl = [[KnowledgeController alloc] init];
    _knowledgeNavCtl = [[BaseUINavigationController alloc] initWithRootViewController:_knowledgeCtl];
    [self initTabBarItem:_knowledgeNavCtl setTitle:L(@"tab_knowledge") setNormalImage:@"ic_tab_knowledge" setSelectedImage:@"ic_tab_knowledge"];
    
    // me
    _meCtl = [[MeController alloc] init];
    _meNavCtl = [[BaseUINavigationController alloc] initWithRootViewController:_meCtl];
    [self initTabBarItem:_meNavCtl setTitle:L(@"tab_me") setNormalImage:@"ic_tab_me" setSelectedImage:@"ic_tab_me"];
    
           
    [self addChildViewController:_homeNavCtl];
    [self addChildViewController:_projectNavCtl];
    [self addChildViewController:_bookNavCtl];
    [self addChildViewController:_knowledgeNavCtl];
    [self addChildViewController:_meNavCtl];
}


-(void)initTabBarItem:(UINavigationController *) controller setTitle:(NSString *)title setNormalImage:(NSString *)normalImage setSelectedImage:(NSString *)selectedImage{
    
    
    UIImage *normal = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    UIImage *selected = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [selected imageWithTint:UIColorFromRGB(0x00A08C)];
    
    
    UITabBarItem *tabBarItem = controller.tabBarItem;
    
    tabBarItem.title = title;
    tabBarItem.image = normal;
    tabBarItem.selectedImage = normal;

    [tabBarItem  setTitleTextAttributes:
     @{NSForegroundColorAttributeName:UIColorFromRGB(0x78A0AA)} forState:UIControlStateNormal];
    [tabBarItem  setTitleTextAttributes:
     @{NSForegroundColorAttributeName:UIColorFromRGB(0x00A08C)} forState:UIControlStateSelected];
    
    controller.tabBarItem = tabBarItem;
        
}



@end
