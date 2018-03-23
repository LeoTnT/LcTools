//
//  LCTabbarController.m
//
//  Created by lichao on 15/11/29.
//  Copyright © 2015年 lichao. All rights reserved.
//

#import "LCTabbarController.h"
#import "LCTabBar.h"
#import "LCNavigationController.h"

#import "LoginViewController.h"
#import "ViewController.h"

@interface LCTabbarController ()<UITabBarControllerDelegate>

@end

@implementation LCTabbarController

#pragma mark -- <初始化tabbar控制器>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置UITabbarItem的属性
    [self setUpItemTitleTextAttributes];
    
    //添加所有子控制器
    [self setUpAllChildVc];
    
    //设置tabBar
    [self setUpTabBar];
    self.delegate = self;
}

/**
 设置tabbar
 */
- (void)setUpTabBar
{
    [self setValue:[[LCTabBar alloc] init] forKey:@"TabBar"];
}


#pragma mark -- 设置UITabbarItem的属性
- (void)setUpItemTitleTextAttributes
{
    //Normal状态下的文字属性
    NSMutableDictionary *NormalAttrs = [NSMutableDictionary dictionary];
    NormalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    NormalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //设置选中状态的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    //利用Appearance对象统一设置文字
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:NormalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


#pragma mark -- 添加所有的子控制器
- (void)setUpAllChildVc
{
    
    [self setUpOneChildVc:[[LCNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] image:@"tabBar_essence_icon"selectedImage:@"tabBar_essence_click_icon" title:@"首页"];
    
    [self setUpOneChildVc:[[LCNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"发现"];
    
    [self setUpOneChildVc:[[LCNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
    [self setUpOneChildVc:[[LCNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我的"];

}


#pragma mark -- 初始化一个子控制器
/**
 初始化一个子控制器

 @param childVc 需要传入的控制器
 @param image tabBar底部的按钮图片
 @param selectedImage tabBar底部的按钮选中状态下的图片
 @param title tabBar底部的标题
 */
- (void)setUpOneChildVc:(UIViewController *)childVc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    childVc.tabBarItem.title = title;
    if (image.length) childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (image.length) childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self addChildViewController:childVc];
}

#pragma mark -- UITabBarControllerDelegate

/**
 在此处控制某个tabBar子控制器是否需要登录
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //登录状态
    BOOL isLogin = YES;
    
    //如果是第三个子控制器 则进行判断是否登录
    if ([tabBarController.viewControllers[2] isEqual:viewController])
    {
        if (!isLogin) {
            LoginViewController *loginVc = [[LoginViewController alloc] init];
            [self presentViewController:loginVc animated:YES completion:nil];
            return NO;
        }
    }
    
    return YES;
}

@end
