//
//  BasedUsingTabBar.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "BasedUsingTabBar.h"
#import "SubTabBar.h"
#import "CXBaseTabBar.h"//添加了 大按钮
@interface BasedUsingTabBar ()

@end

@implementation BasedUsingTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];
    [self createTabbar];
}
-(void)createTabbar{
    
    CXBaseTabBar *baseTabBar =[[CXBaseTabBar alloc] init];
    [self setValue:baseTabBar forKey:@"tabBar"];
    [baseTabBar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
//MARK: - 自定义中心按钮相应方法
- (void)centerBtnClick:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你点击了大按钮" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//MARK: 系统点击回调
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"点击的item:%ld title:%@", item.tag, item.title);
}


#pragma mark ---------- 常规写法 ----------
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
    
    //设置背景图片
    //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //去除 TabBar 自带的顶部阴影  去掉顶部黑线
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    // Bar 的color，设置图片无效
    // [UITabBar appearance].barTintColor = [UIColor yellowColor];
    
    //设置默认选中
    self.selectedIndex = 0;
}
#pragma mark ---------- 设置 item 属性 ----------
- (UITabBarItem *)setTabBarItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)image selectedImage:(NSString *)selctedImage  {
    
    static NSInteger index = 0;
    UITabBarItem *item = [[UITabBarItem alloc] init];
    item.tag = index;
    index++;
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
    //item.badgeValue = @"123";// 提示数字
    //item.titlePositionAdjustment = UIOffsetMake(-2, -2);// 文字偏移
    return item;
}

@end
