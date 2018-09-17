//
//  SpringAnimationTabBar.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "SpringAnimationTabBar.h"

#import "SubTabBar.h"

@interface SpringAnimationTabBar ()<UITabBarControllerDelegate>

@end

@implementation SpringAnimationTabBar {
    NSInteger _currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];
}
- (void)setUpTabBar {
    
    UIColor *titleColor = [UIColor redColor];
    
    //第一个页面
    OneViewController *oneVC = [[OneViewController alloc] init];
    UINavigationController *oneNav = [[UINavigationController alloc] initWithRootViewController:oneVC];
    oneNav.tabBarItem = [self setTabBarItemWithTitle:@"oneVC" titleColor:titleColor image:@"menu-message-normal" selectedImage:@"menu-message-down"];
    
    //第二个页面
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    UINavigationController *twoNav = [[UINavigationController alloc] initWithRootViewController:twoVC];
    twoNav.tabBarItem = [self setTabBarItemWithTitle:@"twoVC" titleColor:titleColor image:@"menu-contact-normal" selectedImage:@"menu-contact-down"];
    
    //第三个页面
    TwoViewController *threeVC = [[TwoViewController alloc] init];
    UINavigationController *threeNav = [[UINavigationController alloc] initWithRootViewController:threeVC];
    threeNav.tabBarItem = [self setTabBarItemWithTitle:@"threeVC" titleColor:titleColor image:@"menu-more-normal" selectedImage:@"menu-more-down"];
    
    //第四个页面
    TwoViewController *fourVC = [[TwoViewController alloc] init];
    UINavigationController *fourNav = [[UINavigationController alloc] initWithRootViewController:fourVC];
    fourNav.tabBarItem = [self setTabBarItemWithTitle:@"fourVC" titleColor:titleColor image:@"menu-message-normal" selectedImage:@"menu-message-down"];
    
    //添加 VC 数组, 设置 tabBar
    NSArray *navArr = @[oneNav,twoNav,threeNav,fourNav];
    self.viewControllers = navArr;
    self.delegate = self;
    
    //设置默认选中
    self.selectedIndex = 0;
}
#pragma mark ---------- 设置 item 属性 ----------
- (UITabBarItem *)setTabBarItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)image selectedImage:(NSString *)selctedImage  {
    
    UITabBarItem *item = [[UITabBarItem alloc] init];
    if (title) { //设置 item 标题
        [item setTitle:title];
    }
    if (titleColor) { //设置 item 点击颜色
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: titleColor}
                            forState:UIControlStateSelected];
    }
    if (image) { //设置 item 常态图片
        [item setImage:[UIImage imageNamed:image]];
    }
    if (selctedImage) { //设置 item 点击图片
        [item setSelectedImage:[[UIImage imageNamed:selctedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return item;
}
#pragma mark ---------- 第一种:添加动画方法(给 item 对象添加动画 - 图片+标题 都会动) ----------

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != _currentIndex) {
        
        [self animationWithIndex:index];
        _currentIndex = index;
    }
    
    //也可以根据标题判断
    if ([item.title isEqualToString:@"首页"]) {
        
    }
}
- (void)animationWithIndex:(NSInteger)index {
    
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabBarButtonArray addObject:tabBarButton];
        }
    }
 
     //CABasicAnimation 类的使用方式就是基本的关键帧动画;
     
     //所谓关键帧动画, 就是讲 Layer 的属性作为 key 来注册, 指定动画的起始和结束帧, 然后自动计算和实现中间的过度动画的一种动画方式
 
    //需要实现的帧动画, 这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.1,@.9,@1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    
    //添加动画
    [[tabBarButtonArray[index] layer] addAnimation:animation forKey:nil];
}

#pragma mark ---------- 第二种:添加动画方法(给 item 上的 imageView 添加动画 - 只有图片动) ----------
/*
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedIndex == 0) {
        
        
    }
    
    // 在点击 tabBarItem 上添加动画
    if (self.selectedIndex != _currentIndex) {
        [self tabBarButtonClick:[self getTabBarButton]];
        //记录所点击的 item
        _currentIndex = self.selectedIndex;
    }
}
//2. 在所点击的 item 对象上的 imageView 子控件上 添加动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    
    for (UIView *imgView in tabBarButton.subviews) {
        
        //获取可切换的 imageView, 添加动画
        if ([imgView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            
            //需要实现的帧动画, 这里根据需求自定义
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.2,@.8,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            
            //添加动画
            [imgView.layer addAnimation:animation forKey:nil];
        }
    }
 
}
//1. 获取 所点击的 item 对象
- (UIControl *)getTabBarButton {
    
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    
    //遍历 tabBar 所有子控件, 根据子控件的名字筛选 所点击的 item 对象
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabBarButtonArray addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = tabBarButtonArray[self.selectedIndex];
    
    return tabBarButton;
}
*/


@end
