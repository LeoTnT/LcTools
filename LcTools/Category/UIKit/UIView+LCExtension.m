//
//  NSObject+LCExtension.m
//
//  Created by lichao on 15/11/29.
//  Copyright © 2015年 lichao. All rights reserved.
//

#import "UIView+LCExtension.h"

@implementation UIView (LCExtension)

+ (instancetype)lc_viewFromNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (BOOL)lc_intersectsWithView:(UIView *)view
{
    
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
    
}

- (void)setLc_centerX:(CGFloat)lc_centerX
{
    CGPoint center = self.center;
    center.x = lc_centerX;
    self.center = center;
}

- (void)setLc_centerY:(CGFloat)lc_centerY
{
    CGPoint center = self.center;
    center.y = lc_centerY;
    self.center = center;
}

- (CGFloat)lc_centerX
{
    return self.center.x;
}

- (CGFloat)lc_centerY
{
    return self.center.y;
}

- (void)setLc_width:(CGFloat)lc_width
{
    CGRect frame = self.frame;
    frame.size.width = lc_width;
    self.frame = frame;
}

- (void)setLc_height:(CGFloat)lc_height
{
    CGRect frame = self.frame;
    frame.size.height = lc_height;
    self.frame = frame;
}


- (CGFloat)lc_width
{
    return self.frame.size.width;
}
- (CGFloat)lc_height
{
    return self.frame.size.height;
}

- (void)setLc_x:(CGFloat)lc_x
{
    CGRect frame = self.frame;
    frame.origin.x = lc_x;
    self.frame = frame;
}

- (void)setLc_y:(CGFloat)lc_y
{
    CGRect frame = self.frame;
    frame.origin.y = lc_y;
    self.frame = frame;
}


- (CGFloat)lc_x
{
    return self.frame.origin.x;
}

- (CGFloat)lc_y
{
    return self.frame.origin.y;
}

@end
