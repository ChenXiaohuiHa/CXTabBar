//
//  CAAnimation+CXAddAnimation.h
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/10.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (CXAddAnimation)

/**
 抖动动画
 
 @param repeatCount 重复次数
 @return 返回关键帧动画
 */
+ (CAKeyframeAnimation *)cx_shakeAnimation_repeatCount:(int)repeatCount;


/**
 透明过渡动画
 
 @param time 持续时间
 @return 返回透明过渡动画
 */
+ (CABasicAnimation *)cx_opacityAnimatioinDurTimes:(float)time;


/**
 缩放动画
 
 @return 返回缩放动画
 */
+ (CABasicAnimation *)cx_scaleAnimation;

+ (CABasicAnimation *)cx_tabBarRotationY;
+ (CABasicAnimation *)cx_tabBarBoundsMin;
+ (CABasicAnimation *)cx_tabBarBoundsMax;

@end
