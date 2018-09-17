//
//  CXTabBar.h
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CXTabBarConfig;
@class CXTabBar;
@protocol CXTabBarDelegate<NSObject>


/**
 选中的 tabBarItem

 @param tabBar tabBar
 @param selectIndex item 索引
 */
- (void)tabBar:(CXTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex;

@end

@interface CXTabBar : UITabBar


/** 代理 */
@property (nonatomic, weak) id <CXTabBarDelegate>myDelegate;

/** selectedIndex (默认为0) */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 初始化, 并赋值
 */
- (instancetype)initWithFrame:(CGRect)frame
                norImageArray:(NSArray *)norImageArray
                selImageArray:(NSArray *)selImageArray
                   titleArray:(NSArray *)titleArray
                 tabBarConfig:(CXTabBarConfig *)tabBarConfig;

@end
