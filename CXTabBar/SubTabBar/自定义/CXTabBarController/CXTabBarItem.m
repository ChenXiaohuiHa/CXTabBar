//
//  CXTabBarItem.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTabBarItem.h"

@implementation CXTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化子控件
        //图片
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        //标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [self addSubview:self.titleLabel];
    }
    return self;
}

#define imgView_Proportion (2.0/3.0)
#define titleLabel_Proportion (1.0/3.0)
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //图片
    CGSize imgSize = [[CXTabBarConfig config] imageSize];//图片大小
    CGFloat imgX = CGRectGetWidth(self.frame)/2 - imgSize.width/2;
    CGFloat imgY = 5;
    if ([[CXTabBarConfig config] layoutType] == CXConfigLayoutTypeImage) {
        
        //只有图片
        imgY = CGRectGetHeight(self.frame)/2 - imgSize.height/2;
        self.imageView.frame = CGRectMake(imgX, imgY, imgSize.width, imgSize.height);
    }else{
        
        self.imageView.frame = CGRectMake(imgX, imgY, imgSize.width, imgSize.height);
        
        //标题
        CGFloat titleX = 4;
        CGFloat titleY = CGRectGetMaxY(self.imageView.frame);
        CGFloat titleW = CGRectGetWidth(self.frame)-8;
        CGFloat titleH = 15;
        self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    }
    
    
    
    //标记值
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame) - 6;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 2;
    CGFloat badgeW = 24;
    CGFloat badgeH = 16;
    self.badgeValue.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
}

//MARK: item 布局
- (void)setLayoutType:(CXConfigLayoutType)layoutType {
    
    _layoutType = layoutType;
    
    if (layoutType == CXConfigLayoutTypeImage) {
        
        self.titleLabel.hidden = YES;
        
        CGSize imageSize = [[CXTabBarConfig config] imageSize];
        
        CGFloat imageX = CGRectGetWidth(self.frame)/2 - imageSize.width/2;
        CGFloat imageY = CGRectGetHeight(self.frame)/2 - imageSize.height/2;
        self.imageView.frame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    }
}

#pragma mark ---------- 懒加载 ----------
- (CXBadgeValue *)badgeValue {
    if (!_badgeValue) {
        _badgeValue = [[CXBadgeValue alloc] init];
        [self addSubview:_badgeValue];
    }
    return _badgeValue;
}

@end
