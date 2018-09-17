//
//  UIView+CXExtension.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/10.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "UIView+CXExtension.h"

@implementation UIView (CXExtension)

- (void)setCx_x:(CGFloat)cx_x
{
    CGRect frame = self.frame;
    frame.origin.x = cx_x;
    self.frame = frame;
}

- (CGFloat)cx_x
{
    return self.frame.origin.x;
}

- (void)setCx_y:(CGFloat)cx_y
{
    CGRect frame = self.frame;
    frame.origin.y = cx_y;
    self.frame = frame;
}

- (CGFloat)cx_y
{
    return self.frame.origin.y;
}

- (void)setCx_w:(CGFloat)cx_w
{
    CGRect frame = self.frame;
    frame.size.width = cx_w;
    self.frame = frame;
}

- (CGFloat)cx_w
{
    return self.frame.size.width;
}

- (void)setCx_h:(CGFloat)cx_h
{
    CGRect frame = self.frame;
    frame.size.height = cx_h;
    self.frame = frame;
}

- (CGFloat)cx_h
{
    return self.frame.size.height;
}

- (void)setCx_size:(CGSize)cx_size
{
    CGRect frame = self.frame;
    frame.size = cx_size;
    self.frame = frame;
}

- (CGSize)cx_size
{
    return self.frame.size;
}

- (void)setCx_origin:(CGPoint)cx_origin
{
    CGRect frame = self.frame;
    frame.origin = cx_origin;
    self.frame = frame;
}

- (CGPoint)cx_origin
{
    return self.frame.origin;
}

@end
