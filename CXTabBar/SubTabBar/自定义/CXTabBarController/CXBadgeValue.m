//
//  CXBadgeValue.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXBadgeValue.h"
#import "CXTabBarConfig.h"
#import "CAAnimation+CXAddAnimation.h"

@implementation CXBadgeValue

#pragma mark - 构造
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.badgeL = [[UILabel alloc] initWithFrame:self.bounds];
        self.badgeL.textColor = [[CXTabBarConfig config] badgeTextColor];
        self.badgeL.font = [UIFont systemFontOfSize:11.f];
        self.badgeL.textAlignment = NSTextAlignmentCenter;
        self.badgeL.layer.cornerRadius = 8.f;
        self.badgeL.layer.masksToBounds = YES;
        self.badgeL.backgroundColor = [[CXTabBarConfig config] badgeBackgroundColor];
        [self addSubview:self.badgeL];
    }
    return self;
}


- (void)setType:(CXBadgeValueType)type {
    _type = type;
    
    //改变 控件 外形 坐标
    if (type == CXBadgeValueTypePoint) {
        self.badgeL.text = @"";
        //将 view 坐标更改为 圆点
        self.badgeL.cx_size = CGSizeMake(10, 10);
        self.badgeL.layer.cornerRadius = 5;
        self.badgeL.cx_x = 0;
        self.badgeL.cx_y = self.cx_h/2 -self.badgeL.cx_size.height/2;
    }else if (type == CXBadgeValueTypeNew) {
        
        self.badgeL.cx_size = CGSizeMake(self.cx_w, self.cx_h);
    }else if (type == CXBadgeValueTypeNumber) {
        
        CGSize size = CGSizeZero;
        CGFloat radius = 8.0f;
        if (self.badgeL.text.length <= 1) {
            
            size = CGSizeMake(self.cx_h, self.cx_h);
            radius = self.cx_h/2;
        }else if (self.badgeL.text.length > 1) {
            
            size = self.bounds.size;
            radius = 8.0f;
        }
        
        self.badgeL.cx_size = size;
        self.badgeL.layer.cornerRadius = radius;
    }
    
    //给控件添加动画
    CXConfigBadgeAnimType animType = [[CXTabBarConfig config] animType];
    if (animType == CXConfigBadgeAnimTypeShake) { //抖动
        
        [self.badgeL.layer addAnimation:[CAAnimation cx_shakeAnimation_repeatCount:5] forKey:@"shakeAnimation"];
    }else if (animType == CXConfigBadgeAnimTypeOpacity) { //透明过渡动画
        
        [self.badgeL.layer addAnimation:[CAAnimation cx_opacityAnimatioinDurTimes:0.3] forKey:@"opacityAnimation"];
    }else if (animType == CXConfigBadgeAnimTypeScale) { //缩放动画
        
        [self.badgeL.layer addAnimation:[CAAnimation cx_scaleAnimation] forKey:@"scaleAnimation"];
    }
}

- (CGSize)sizeWithAttribute:(NSString *)text {
    return [text sizeWithAttributes:@{NSFontAttributeName:self.badgeL.font}];
}

@end
