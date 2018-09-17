//
//  CXTabBarController.h
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/9.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXTabBarConfig.h"
#import "CXTabBar.h"
@interface CXTabBarController : UITabBarController

/** tabBar */
@property (nonatomic, strong) CXTabBar *cx_tabBar;

/**
 初始化 tabBarController

 @param controllers  子控制器
 @param norImageArray 常规图片
 @param selImageArray 选中图片
 @param titleArray 标题
 @param tabBarConfig 配置
 @return  tabBarController 对象
 */
- (instancetype)initWithTabBarControllers:(NSArray *)controllers
                            norImageArray:(NSArray *)norImageArray
                            selImageArray:(NSArray *)selImageArray
                               titleArray:(NSArray *)titleArray
                             tabBarConfig:(CXTabBarConfig *)tabBarConfig;
//[AxcAE_TabBar](https://github.com/axclogo/AxcAE_TabBar)
@end
