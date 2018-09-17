//
//  CXBaseTabBar.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/24.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXBaseTabBar.h"

@implementation CXBaseTabBar

- (instancetype)init {
    self = [super init];
    if (self) {
        
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        _centerBtn = btn;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds)/(self.items.count + 1);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat x = 0;
    int index = 0;
    for (UIView *view in self.subviews) {
        
        //遍历 tabBar 上所有 item
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == 2) { 
                index += 1;
            }
            view.frame = CGRectMake((x + width * index), 0, width, height);
            index += 1;
        }
    }
    self.centerBtn.center = CGPointMake(CGRectGetWidth(self.bounds)/2, 0);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    
    UIView *result = [super hitTest:point withEvent:event];
    //如果发生在 tabBar 里面直接返回
    if (result) {
        return result;
    }
    //这里遍历哪些超出部分, 通用写法
    for (UIView *subview in self.subviews) {
        
        //把这个坐标从 tabBar 的坐标系转为 subView 的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        //如果事件发生在 subview 里, 就返回
        if (result) {
            return result;
        }
    }
    
    return nil;
}

@end
