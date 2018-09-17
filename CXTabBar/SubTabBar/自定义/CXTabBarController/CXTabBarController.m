//
//  CXTabBarController.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/9.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTabBarController.h"

@interface CXTabBarController ()<CXTabBarDelegate>

@end

@implementation CXTabBarController

- (instancetype)initWithTabBarControllers:(NSArray *)controllers
                            norImageArray:(NSArray *)norImageArray
                            selImageArray:(NSArray *)selImageArray
                               titleArray:(NSArray *)titleArray
                             tabBarConfig:(CXTabBarConfig *)tabBarConfig {
    
    self.viewControllers = controllers;
    self.cx_tabBar = [[CXTabBar alloc] initWithFrame:self.tabBar.frame
                                       norImageArray:norImageArray
                                       selImageArray:selImageArray titleArray:titleArray tabBarConfig:tabBarConfig];
    self.cx_tabBar.myDelegate = self;
    
    //将 tabBarController 对象赋值给 配置类
    [CXTabBarConfig config].tabBarController = self;
    
    //KVC 将自定义的 CXTabBar 替换 系统的 tabBar(更换系统自带的tabbar)
    [self setValue:self.cx_tabBar forKeyPath:@"tabBar"];
    //KVO 监听系统 tabBar 的 selectedIndex 属性值得变化(设置默认选中, 同时根据选择的 index 显示动画)
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    //获取系统 tabBar 的 selectedIndex 最新值
    NSInteger selectedIndex = [change[@"new"] integerValue];
    
    NSLog(@"系统 tabBar 的 selectedIndex 最新值: %ld",selectedIndex);
    //将最新值赋值给 自定义 tabBar 的 selectedIndex
    self.cx_tabBar.selectedIndex = selectedIndex;
}

#pragma mark ---------- tabBar 协议方法 ----------
- (void)tabBar:(CXTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex {
    
    //选择的 item 的索引, self.selectedIndex 值改变,触发 KVO 事件
    self.selectedIndex = selectIndex;
}

- (void)dealloc {
    //被销毁了
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
