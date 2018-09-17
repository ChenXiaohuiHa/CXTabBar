//
//  CXTabBarConfig.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTabBarConfig.h"
#import "CXTabBarItem.h"
#import "CXTabBarController.h"
@implementation CXTabBarConfig

#pragma mark ---------- 初始化 单例对象 ----------
static CXTabBarConfig *_tabBarConfig = nil;
+ (instancetype)config {
    
    return [[self alloc] init];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tabBarConfig = [super allocWithZone:zone];
    });
    return _tabBarConfig;
}
- (instancetype)init {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tabBarConfig = [super init];
        [self configNormal];
    });
    return _tabBarConfig;
}
#pragma mark ---------- 设置默认值 ----------
- (void)configNormal {
    
    _titleNorColor = [self colorWithHexString:@"#808080" Alpha:1];
    _titleSelColor = [self colorWithHexString:@"#d81e06" Alpha:1];
    _layoutType = CXConfigLayoutTypeNormal;
    _imageSize = CGSizeMake(28, 28);
    _isClearTabBarTopLine = YES;
    _tabBarTopLineColor = [UIColor lightGrayColor];
    _tabBarBackgroundColor = [UIColor whiteColor];
    _badgeTextColor = [self colorWithHexString:@"#FFFFFF" Alpha:1];
    _badgeBackgroundColor = [self colorWithHexString:@"#FF4040" Alpha:1];
    _automaticHidden = YES;
}


#pragma mark ---------- badgeValue 基本配置 ----------

- (void)setBadgeSize:(CGSize)badgeSize {
    _badgeSize = badgeSize;
    NSMutableArray *array = [self getTabBarItems];
    for (CXTabBarItem *item in array) {
        item.badgeValue.badgeL.cx_size = badgeSize;
    }
}
- (void)setBadgeOffset:(CGPoint)badgeOffset {
    _badgeOffset = badgeOffset;
    NSMutableArray *array = [self getTabBarItems];
    for (CXTabBarItem *item in array) {
        item.badgeValue.badgeL.cx_x += badgeOffset.x;
        item.badgeValue.badgeL.cx_y += badgeOffset.y;
    }
}
- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeTextColor = badgeTextColor;
    NSMutableArray *array = [self getTabBarItems];
    for (CXTabBarItem *item in array) {
        item.badgeValue.badgeL.textColor = badgeTextColor;
    }
}
- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    _badgeBackgroundColor = badgeBackgroundColor;
    NSMutableArray *array = [self getTabBarItems];
    for (CXTabBarItem *item in array) {
        item.badgeValue.badgeL.backgroundColor = badgeBackgroundColor;
    }
}
- (void)setBadgeRadius:(CGFloat)badgeRadius {
    _badgeRadius = badgeRadius;
    NSMutableArray *array = [self getTabBarItems];
    for (CXTabBarItem *item in array) {
        item.badgeValue.badgeL.layer.cornerRadius = badgeRadius;
    }
}
- (void)setAutomaticHidden:(BOOL)automaticHidden {
    _automaticHidden = automaticHidden;
    NSMutableArray *array = [self getTabBarItems];
    for (CXTabBarItem *item in array) {
        item.badgeValue.hidden = automaticHidden;
    }
}

/**
 对单个 item 进行圆角设置
 
 @param radius 圆角值
 @param index 下标
 */
- (void)badgeRadius:(CGFloat)radius anIndex:(NSInteger)index {
    CXTabBarItem *item = [self getTabBarItemAtIndex:index];
    item.badgeValue.layer.cornerRadius = radius;
}

/**
 显示圆点 badge (一下关于 badgeValue 的方法可以在app 全局操作, 使用方法: [[CXTabBarConfig config] showPointBadgeValue: AtIndex: ])
 
 @param index 显示的下标
 */
- (void)showPointBadgeAtIndex:(NSInteger)index {
    CXTabBarItem *item = [self getTabBarItemAtIndex:index];
    item.badgeValue.hidden = NO;
    item.badgeValue.type = CXBadgeValueTypePoint;
}

/**
 显示new
 
 @param index  下标
 */
- (void)showNewBadgeAtIndex:(NSInteger)index {
    CXTabBarItem *item = [self getTabBarItemAtIndex:index];
    item.badgeValue.hidden = NO;
    item.badgeValue.badgeL.text = @"new";
    item.badgeValue.type = CXBadgeValueTypeNew;
}

/**
 显示带数值的下标
 
 @param badgeValue 数值
 @param index 下标
 */
- (void)showNumberBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index {
    CXTabBarItem *item = [self getTabBarItemAtIndex:index];
    item.badgeValue.hidden = NO;
    item.badgeValue.badgeL.text = badgeValue;
    item.badgeValue.type = CXBadgeValueTypeNumber;
}

/**
 隐藏下标
 
 @param index 下标
 */
- (void)hideBadgeAtIndex:(NSInteger)index {
    
    [self getTabBarItemAtIndex:index].badgeValue.hidden = YES;
}

/**
 添加自定义按钮
 
 @param btn 自定义 btn
 @param index 添加的下标位置
 @param btnClickBlock 按钮点击事件回调
 */
- (void)addCustomItem:(UIButton *)btn atIndex:(NSInteger)index btnClickBlock:(CXConfigCustomBtnBlock)btnClickBlock {
    
    btn.tag = index;
    [btn addTarget:self action:@selector(customBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnClickBlock = btnClickBlock;
    [self.tabBarController.cx_tabBar addSubview:btn];
}
- (void)customBtnClick:(UIButton *)sender {
    
    if (self.btnClickBlock) {
        self.btnClickBlock(sender, sender.tag);
    }
}

//根据索引获取对应的 tabBarItem
- (CXTabBarItem *)getTabBarItemAtIndex:(NSInteger)index {
    NSArray *items = [self getTabBarItems];
    
    for (int i = 0; i < items.count; i++) {
        
        if (index == i) {
        
            return items[i];
        }
    }
    return nil;
}
//获取 tabBarItem 所有子控件
- (NSMutableArray *)getTabBarItems {
    
    NSArray *subViews = self.tabBarController.cx_tabBar.subviews;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[CXTabBarItem class]]) {
            
            CXTabBarItem *tabBarItem = (CXTabBarItem *)view;
            [tempArr addObject:tabBarItem];
        }
    }
    
    return tempArr;
}
#pragma mark ---------- Private Methods ----------
#pragma mark ---------- 色值转换 ----------
- (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    //判断前缀
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    //从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R G B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

@end
