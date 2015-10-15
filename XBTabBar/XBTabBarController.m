//
//  XBTabBarController.m
//  XBTabBar
//
//  Created by guoxb on 15/10/15.
//  Copyright © 2015年 guoxb. All rights reserved.
//

#import "XBTabBarController.h"

@interface XBTabBarController ()<XBTabBarDelegate>
{
    XBViewController1 *_viewController1;
    XBViewController2 *_viewController2;
    XBViewController3 *_viewController3;
    XBViewController4 *_viewController4;
}

@property (nonatomic, strong) XBTabBar *customTabBar;

@end

@implementation XBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tabBar
    [self setupTabbar];
    //初始化所有子控制器
    [self setupAllChildViewControllers];
    
    //中间按钮事件
    [_customTabBar.plusButton addTarget:self action:@selector(addBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - private

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    XBTabBar *customTabBar = [[XBTabBar alloc] init];
    customTabBar.frame = CGRectMake(0, 0, SCREENWIDTH, 59);
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 * 初始化所有的子控制器
 */
- (void)setupAllChildViewControllers{
    //1.
    _viewController1 = [[XBViewController1 alloc] init];
    [self setupChildViewController:_viewController1 Title:@"首页" ImageName:@"index_Nomal" SelectedImageName:@"index_Selected"];
    
    //2.
    _viewController2 = [[XBViewController2 alloc] init];
    [self setupChildViewController:_viewController2 Title:@"消息" ImageName:@"index_Nomal" SelectedImageName:@"index_Selected"];
    
    //3.
    _viewController3 = [[XBViewController3 alloc] init];
    [self setupChildViewController:_viewController3 Title:@"发现" ImageName:@"index_Nomal" SelectedImageName:@"index_Selected"];
    
    //4.
    _viewController4 = [[XBViewController4 alloc] init];
    [self setupChildViewController:_viewController4 Title:@"我的" ImageName:@"index_Nomal" SelectedImageName:@"index_Selected"];
}

- (void)setupChildViewController:(UIViewController *)childVC Title:(NSString *)title ImageName:(NSString *)imageName SelectedImageName:(NSString *)selectedImageName {
    //1.设置控制器的属性
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    //2.导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
    
    //3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVC.tabBarItem];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBar.frame = CGRectMake(0, SCREENHEIGHT-59, SCREENWIDTH, 59);
    [self.tabBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor clearColor]]];
    [self.tabBar setShadowImage:[UIImage imageFromContextWithColor:[UIColor clearColor]]];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark - XBTabBarDelegate

-(void)tabBar:(XBTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    self.selectedIndex = to;
}

-(void)addBtnAction:(UIButton *)button{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"Add Button Clicked" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alertView show];
}

@end
