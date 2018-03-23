//
//  LCUITabBar.m
//
//  Created by lichao on 15/11/30.
//  Copyright © 2015年 lichao. All rights reserved.
//

#import "LCTabBar.h"
#import "UIView+LCExtension.h"

@interface LCTabBar()

/*发布按钮*/
//@property(nonatomic, weak) UIButton *publishBtn;

/**
 *  被点击的索引
 */
@property(nonatomic, assign) NSUInteger selectedIndex;

@end

@implementation LCTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
    }
    return self;
}

#pragma mark - 懒加载

//- (UIButton *)publishBtn
//{
//    if (!_publishBtn) {
//        
//        UIButton *publishBtn = [[UIButton alloc] init];
//        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
//      
//        //添加监听
//        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self addSubview:publishBtn];
//        _publishBtn = publishBtn;
//        
//    }
//    
//    return _publishBtn;
//}

#pragma mark - 添加发布监听
//- (void)publishClick
//{
//    NSLog(@"%s", __func__);
//}

#pragma mark - <重写frame - 系统内部的方法>
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    //tabBar按钮的宽和高
//    CGFloat buttonW = self.lc_width * 0.2;
//    CGFloat buttonH = self.lc_height;
//    
//    //设置publishbutton的frame
//    self.publishBtn.lc_width = buttonW;
//    self.publishBtn.lc_height = buttonH;
//    self.publishBtn.center = CGPointMake(self.lc_width * 0.5, self.lc_height * 0.5);
//    
//    //设置tabBarButton的frame
//    int tabBarButtonIndex = 0;
//    
//    for (UIControl *tabBarButton in self.subviews) {
//        //判断是不是按钮控件
//        if(![@"UITabBarButton" isEqualToString:NSStringFromClass(tabBarButton.class)]) continue;
//
//        tabBarButton.lc_width = buttonW;
//        tabBarButton.lc_height = buttonH;
//        tabBarButton.lc_y = 0;
//        tabBarButton.tag = tabBarButtonIndex;
//        tabBarButton.lc_x = tabBarButtonIndex * buttonW;
//        
//        if (tabBarButtonIndex >= 2) {
//            tabBarButton.lc_x += buttonW;
//        }
//        
//        tabBarButtonIndex++;
//        //添加监听
//        [tabBarButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//}

#pragma mark 监听tabar点击
- (void)buttonClick:(UIControl *)tabBarButton
{
    
    if (self.selectedIndex == tabBarButton.tag) {//如果重复点击tabarButton
//        //发通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:LCTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.selectedIndex = tabBarButton.tag;
    
}




@end
