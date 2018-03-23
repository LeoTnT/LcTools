//
//  LCTextField.m
//  LcTools
//
//  Created by lichao on 2017/7/31.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "LCTextField.h"

@implementation LCTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {

//    //设置border
//    self.layer.cornerRadius = 6;
//    self.layer.masksToBounds = YES;
//    self.backgroundColor = [UIColor whiteColor];
//    self.layer.borderColor = [UIColor blackColor].CGColor;
//    self.layer.borderWidth = 1;
    
    //设置字体
    self.font = [UIFont systemFontOfSize:16];
    //字体颜色
    self.textColor = [UIColor blackColor];
    //占位符的颜色和大小
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    //不成为第一响应者
    [self resignFirstResponder];
}

/* 当前textfield成为第一响应者时 */
- (BOOL)becomeFirstResponder {
    //修改占位文字颜色
    [self setValue:self.textColor forKey:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
/* 当前textfield失去第一响应者时 */
- (BOOL)resignFirstResponder {
    //修改占位文字颜色
    [self setValue:[UIColor grayColor] forKey:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

/* 控制placeholder的位置 */
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width-15, bounds.size.height);
    return inset;
}

/* 控制显示文本的位置 */
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    return inset;
}

/* 控制编辑文本的位置 */
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +15, bounds.origin.y, bounds.size.width -15, bounds.size.height);
    return inset;
}

@end
