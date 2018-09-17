//
//  CAAnimation+CXAddAnimation.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/10.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CAAnimation+CXAddAnimation.h"
#import <UIKit/UIKit.h>

#define angle2Rad(angle) ((angle) / 180.0 * M_PI)

@implementation CAAnimation (CXAddAnimation)

/**
 抖动动画
 */
+ (CAKeyframeAnimation *)cx_shakeAnimation_repeatCount:(int)repeatCount {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.values = @[@(angle2Rad(-15)),@(angle2Rad(-10)),@(angle2Rad(-7)),@(angle2Rad(-5)),@(angle2Rad(0)),@(angle2Rad(5)),@(angle2Rad(-7)),@(angle2Rad(10)),@(angle2Rad(15))];
    animation.repeatCount = repeatCount;
    return animation;
}

/**
 透明过渡动画
 */
+ (CABasicAnimation *)cx_opacityAnimatioinDurTimes:(float)time {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @1;
    animation.toValue = @.2;
    animation.repeatCount = 3;
    animation.duration = time;
    animation.autoreverses = YES;
    return animation;
}

/**
 缩放动画
 */
+ (CABasicAnimation *)cx_scaleAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = @1.2;
    animation.repeatCount = 3;
    animation.duration = 0.3;
    animation.autoreverses = YES;
    return animation;
}

/**
 Y 轴旋转
 */
+ (CABasicAnimation *)cx_tabBarRotationY {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = @(M_PI * 2);
    return animation;
}
+ (CABasicAnimation *)cx_tabBarBoundsMin {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(12, 12)];
    return animation;
}
+ (CABasicAnimation *)cx_tabBarBoundsMax {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(46, 46)];
    return animation;
}

@end
