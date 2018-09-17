//
//  CXTabBarConfig.h
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

//自定义log
#ifdef DEBUG
#define CXLog(...) NSLog(__VA_ARGS__)
#else
#define CXLog(...)
#endif

//随机颜色+RGB颜色+RBGA颜色+16进制颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+CXExtension.h"
@class CXTabBarController;

/** tabBarItem 图片文字布局 */
typedef NS_ENUM(NSInteger, CXConfigLayoutType) {
    CXConfigLayoutTypeNormal, //默认布局, 图片上, 文字下
    CXConfigLayoutTypeImage,  //只有图片
};

/**  tabBarItem 动画枚举 */
typedef NS_ENUM(NSInteger, CXConfigTabBarAnimType) {
    CXConfigTabBarAnimTypeNormal, //无动画
    CXConfigTabBarAnimTypeRotationY, //Y轴旋转
    CXConfigTabBarAnimTypeBoundsMin, //缩小
    CXConfigTabBarAnimTypeBoundsMax, //放大
    CXConfigTabBarAnimTypeScale, //缩放动画
};

/** badgeValue 动画枚举 */
typedef NS_ENUM(NSInteger, CXConfigBadgeAnimType) {
    CXConfigBadgeAnimTypeNormal, //无动画
    CXConfigBadgeAnimTypeShake, //抖动动画
    CXConfigBadgeAnimTypeOpacity, //透明过渡动画
    CXConfigBadgeAnimTypeScale, //缩放动画
};

@interface CXTabBarConfig : NSObject


/**
 单例
 */
+ (instancetype)config;

/**
 恢复默认设置(开发测试使用)
 */
- (void)configNormal;

/******************************** tabBar 基本配置 ********************************/

/** item 布局类型(默认:图片,文字下) */
@property (nonatomic, assign) CXConfigLayoutType layoutType;
/** 标题默认颜色 */
@property (nonatomic, strong) UIColor *titleNorColor;
/** 标题选中颜色 */
@property (nonatomic, strong) UIColor *titleSelColor;
/** 图片的size (默认 28*28) */
@property (nonatomic, assign) CGSize imageSize;
/** tabBar 背景颜色(默认白色) */
@property (nonatomic, strong) UIColor *tabBarBackgroundColor;
/** 是否显示tabBar顶部线条颜色 (默认 YES) */
@property (nonatomic, assign) BOOL isClearTabBarTopLine;
/** tabBar顶部线条颜色 (默认亮灰色) */
@property (nonatomic, strong) UIColor *tabBarTopLineColor;

/** tabBarController */
@property (nonatomic, strong) CXTabBarController *tabBarController;
/** tabBar 动画 */
@property (nonatomic, assign)  CXConfigTabBarAnimType tabBarAnimType;


/******************************** badgeValue 基本配置 ********************************/

/** badgeColor(默认 #FFFFFF) */
@property (nonatomic, strong) UIColor *badgeTextColor;
/** badgeBackgroundColor (默认 #FF4040)*/
@property (nonatomic, strong) UIColor *badgeBackgroundColor;
/** badgeSize (如没有特殊需求, 请勿修改此属性, 此属性只有在控制器加载完成后有效)*/
@property (nonatomic, assign) CGSize badgeSize;
/** badgeOffset (如没有特殊需求, 请勿修改此属性, 此属性只有在控制器加载完成后有效) */
@property (nonatomic, assign) CGPoint badgeOffset;
/** badge圆角大小 (如没有特殊需求, 请勿修改此属性, 此属性只有在控制器加载完成后有效, 一般配合badgeSize或badgeOffset使用) */
@property (nonatomic, assign) CGFloat badgeRadius;
// 为零是否自动隐藏 默认不隐藏
@property(nonatomic, assign)BOOL automaticHidden;
/** badge动画 (默认无动画) */
@property (nonatomic, assign) CXConfigBadgeAnimType animType;

/**
 对单个 item 进行圆角设置

 @param radius 圆角值
 @param index 下标
 */
- (void)badgeRadius:(CGFloat)radius anIndex:(NSInteger)index;

/**
 显示圆点 badge (一下关于 badgeValue 的方法可以在app 全局操作, 使用方法: [[CXTabBarConfig config] showPointBadgeValue: AtIndex: ])

 @param index 显示的下标
 */
- (void)showPointBadgeAtIndex:(NSInteger)index;

/**
 显示new

 @param index  下标
 */
- (void)showNewBadgeAtIndex:(NSInteger)index;

/**
 显示带数值的下标

 @param badgeValue 数值
 @param index 下标
 */
- (void)showNumberBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index;

/**
 隐藏下标

 @param index 下标
 */
- (void)hideBadgeAtIndex:(NSInteger)index;


/******************************** 自定义按钮 基本配置 ********************************/

typedef void (^CXConfigCustomBtnBlock) (UIButton *btn, NSInteger index);
/** item 点击回调 */
@property (nonatomic, strong) CXConfigCustomBtnBlock btnClickBlock;

/**
 添加自定义按钮

 @param btn 自定义 btn
 @param index 添加的下标位置
 @param btnClickBlock 按钮点击事件回调
 */
- (void)addCustomItem:(UIButton *)btn atIndex:(NSInteger)index btnClickBlock:(CXConfigCustomBtnBlock)btnClickBlock;


@end
