//
//  LCNavigationController.m
//
//  Created by lichao on 15/12/4.
//  Copyright © 2015年 lichao. All rights reserved.
//

#import "LCNavigationController.h"

@interface LCNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    //设置导航栏背景
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏文字
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:16]
                                                 }];
    
}

//目的:拦截到所有push进来的子控制器
#pragma mark - 重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];

}

#pragma mark 监听点击方法
- (void)back
{
    NSLog(@"back");
    [self popViewControllerAnimated:YES];
}

#pragma mark <UIGestureRecognizerDelegate代理方法>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //当子控制器 > 1 的时候有效
    return self.childViewControllers.count > 1;
}


@end
