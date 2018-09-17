//
//  TwoViewController.m
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "TwoViewController.h"
#import "UITabBarController+tabBarController.h"
@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"TwoVC";
    self.view.backgroundColor = [UIColor blueColor];
    [self createBtn];
}
- (void)createBtn {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.center = self.view.center;
    btn.bounds = CGRectMake(0, 0, 150, 50);
    [btn setTitle:@"隐藏/显示 tabBar" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)btnClick {
    
    static int count = 0;
    count ++;
    if (count %2) {
        [self.tabBarController hideTabBar:YES animated:YES];
    }else{
        [self.tabBarController hideTabBar:NO animated:YES];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
