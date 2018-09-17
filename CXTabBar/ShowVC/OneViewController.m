//
//  OneViewController.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "OneViewController.h"
#import "CXTabBarController.h"
@interface OneViewController ()

@end

@implementation OneViewController {
    
    NSArray *_titArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"OneVC";
    self.view.backgroundColor = [UIColor cyanColor];
    
    _titArr = @[@"badgeValue 样式 -> new",
                        @"badgeValue 样式 -> 点",
                        @"badgeValue 样式 -> 消息提示",
                        @"badgeValue 动画 -> 抖动",
                        @"badgeValue 动画 -> 闪烁",
                        @"badgeValue 动画 -> 缩放"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.presentingViewController) {
        
        //present 方式进入, 表明是自定义 tabBar
        [self setUpUI];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.presentingViewController) {
        
        //present 方式进入, 表明是自定义 tabBar
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

// 宽度(自定义)
#define PIC_WIDTH 150
// 高度(自定义)
#define PIC_HEIGHT 40
// 列数(自定义)
#define COL_COUNT 2
- (void)setUpUI {
    
    
    CGFloat top = 64;
    // 间距
    CGFloat margin = (self.view.bounds.size.width - (PIC_WIDTH * COL_COUNT)) / (COL_COUNT + 1);
    
    for (int i = 0 ; i< _titArr.count; i++) {
        
        NSInteger row = i / COL_COUNT;
        NSInteger col = i % COL_COUNT;
        // PointX
        CGFloat X = margin + (PIC_WIDTH + margin) * col;
        // PointY
        CGFloat Y = margin + (PIC_HEIGHT + margin) * row;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(X, Y+top, PIC_WIDTH, PIC_HEIGHT);
        [btn setTitle:_titArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (void)btnClick:(UIButton *)sender {
    
    //3. badgeValue 样式和动画
    //关于badgeValue的样式可全局配置
    CXTabBarConfig *config = [CXTabBarConfig config];
    switch (sender.tag) {
        case 0:
            
            [config showPointBadgeAtIndex:0];
            break;
        case 1:
            [config showNewBadgeAtIndex:1];
            break;
        case 2:
            //config.badgeTextColor = [UIColor greenColor];//更改字体颜色
            [config showNumberBadgeValue:@"99+" atIndex:2];
            break;
        case 3:
            config.animType = CXConfigBadgeAnimTypeShake;
            [config showNumberBadgeValue:@"99+" atIndex:1];
            break;
        case 4:
            config.animType = CXConfigBadgeAnimTypeOpacity;
            [config showNumberBadgeValue:@"99+" atIndex:2];
            break;
        case 5:
            config.animType = CXConfigBadgeAnimTypeScale;
            [config showNumberBadgeValue:@"99+" atIndex:3];
            break;
            
        default:
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
