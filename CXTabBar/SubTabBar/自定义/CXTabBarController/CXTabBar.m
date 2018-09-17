//
//  CXTabBar.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTabBar.h"
#import "CXTabBarConfig.h"
#import "CXTabBarItem.h"
#import "CAAnimation+CXAddAnimation.h"

@interface CXTabBar ()

/** 存放 CXTabBarItem 数组 */
@property (nonatomic, strong) NSMutableArray *saveTabBarArr;
/** norImage */
@property (nonatomic, strong) NSMutableArray *norImageArr;
/** SelImage */
@property (nonatomic, strong) NSMutableArray *selImageArr;
/** titleArr */
@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation CXTabBar

- (NSMutableArray *)saveTabBarArr {
    if (!_saveTabBarArr) {
        _saveTabBarArr = [NSMutableArray array];
    }
    return _saveTabBarArr;
}

#pragma mark ---------- 初始化 ----------
- (instancetype)initWithFrame:(CGRect)frame
                norImageArray:(NSArray *)norImageArray
                selImageArray:(NSArray *)selImageArray
                   titleArray:(NSArray *)titleArray
                 tabBarConfig:(CXTabBarConfig *)tabBarConfig {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createTabBarItemWithNorImageArray:norImageArray selImageArray:selImageArray titleArray:titleArray tabBarConfig:tabBarConfig];
        
        //背景颜色处理
        if ([tabBarConfig tabBarBackgroundColor]) {
            self.backgroundColor = [tabBarConfig tabBarBackgroundColor];
        }else{
            self.backgroundColor = [UIColor whiteColor];
        }
        
        
        //顶部线条处理
        if (tabBarConfig.isClearTabBarTopLine) {
            [self topLineIsClearColor:YES];
        }else{
            [self topLineIsClearColor:NO];
        }
    }
    return self;
}
#pragma mark ---------- 创建 item ----------
- (void)createTabBarItemWithNorImageArray:(NSArray *)norImageArray
                        selImageArray:(NSArray *)selImageArray
                           titleArray:(NSArray *)titleArray
                         tabBarConfig:(CXTabBarConfig *)tabBarConfig {
    
    for (int i = 0; i < titleArray.count; i++) {
        
        //创建 item
        CXTabBarItem *item = [[CXTabBarItem alloc] init];
        item.imageView.image = [UIImage imageNamed:norImageArray[i]];
        item.titleLabel.text = titleArray[i];
        item.tag = i;
        [self addSubview:item];
        
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemAction:)];
        [item addGestureRecognizer:tap];
        
        //保存 数据, 用户点击动画
        [self.saveTabBarArr addObject:item];
        self.norImageArr = [NSMutableArray arrayWithArray:norImageArray];
        self.selImageArr = [NSMutableArray arrayWithArray:selImageArray];
        self.titleArr = [NSMutableArray arrayWithArray:titleArray];
    }
}
//MARK: 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //CXTabBarItem 替换系统 类 UITabBarButton
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UIView *tabBarButton in self.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[CXTabBarItem class]] || [tabBarButton isKindOfClass:[UIButton class]]) {
            [tempArr addObject:tabBarButton];
        }
    }
    
    //排序
    for (UIView *view in tempArr) {
        if ([view isKindOfClass:[UIButton class]]) {
            [tempArr insertObject:view atIndex:view.tag];
            [tempArr removeLastObject];
            break;
        }
    }
    
    //设置坐标
    CGFloat viewW = CGRectGetWidth(self.frame)/tempArr.count;
    CGFloat viewH = 49;
    CGFloat viewY = 0;
    for (int i = 0; i < tempArr.count; i++) {
        CGFloat viewX = i *viewW;
        UIView *view = tempArr[i];
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
}
//MARK: item 点击事件
- (void)itemAction:(UITapGestureRecognizer *)tap {
    
    NSLog(@"item 点击事件: %ld",tap.view.tag);
    
    //点击动画
    [self setUpSelectedIndex:tap.view.tag];
    
    //协议方法, tabBarController 中可监听点击事件
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didSelectIndex:)]) {
        [self.myDelegate tabBar:self didSelectIndex:tap.view.tag];
    }
}
#pragma mark ---------- 设置选中的index进行操作(选中动画) ----------
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    //点击动画
    [self setUpSelectedIndex:selectedIndex];
}
//MARK: 设置选中的index进行操作
- (void)setUpSelectedIndex:(NSInteger)selectedIndex {
    
    NSLog(@"设置选中的index进行操作: %ld",selectedIndex);
    for (int i = 0; i < self.saveTabBarArr.count; i++) {
        
        CXTabBarItem *item = self.saveTabBarArr[i];
        
        if (selectedIndex == i) { //如果 i 与点击的 index 相同, 执行动画
            
            //选中颜色和图片
            item.titleLabel.textColor = [[CXTabBarConfig config] titleSelColor];
            item.imageView.image = [UIImage imageNamed:self.selImageArr[i]];
            
            //添加动画
            CXConfigTabBarAnimType type = [[CXTabBarConfig config] tabBarAnimType];
            if (type == CXConfigTabBarAnimTypeRotationY) { //Y 轴旋转动画
                
                [item.layer addAnimation:[CAAnimation cx_tabBarRotationY] forKey:@"rotationAnimation"];
            }else if (type == CXConfigTabBarAnimTypeScale) {
                
                //向上移动 15 坐标点
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
                CGPoint point = item.imageView.frame.origin;
                point.y -= 15;
                animation.toValue = @(point.y);
                //图片方法 1.3倍
                CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                animation2.toValue = @(1.3);
                
                CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
                groupAnimation.fillMode = kCAFillModeForwards;
                groupAnimation.removedOnCompletion = NO;
                groupAnimation.animations = @[animation,animation2];
                
                [item.imageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
            }else if (type == CXConfigTabBarAnimTypeBoundsMax) {
                
                [item.imageView.layer addAnimation:[CAAnimationGroup cx_tabBarBoundsMax] forKey:@"maxAnimation"];
            }else if (type == CXConfigTabBarAnimTypeBoundsMin) {
                
                [item.imageView.layer addAnimation:[CAAnimationGroup cx_tabBarBoundsMin] forKey:@"minAnimation"];
            }
        }else{ //tabBarItem 恢复常态
            
            //默认颜色和图片
            item.titleLabel.textColor = [[CXTabBarConfig config] titleNorColor];
            item.imageView.image = [UIImage imageNamed:self.norImageArr[i]];
            [item.imageView.layer removeAllAnimations];
        }
    }
}

#pragma mark ---------- 顶部线条处理(是否清除颜色) ----------
- (void)topLineIsClearColor:(BOOL)isClearColor {
    
    UIColor *color = [UIColor clearColor];
    if (!isClearColor) {
        color = [[CXTabBarConfig config] tabBarTopLineColor];
    }
    
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.frame), 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:img];
}

@end
