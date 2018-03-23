//
//  LoginViewController.m
//  BaseControllerDemo
//
//  Created by lichao on 2017/3/24.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
