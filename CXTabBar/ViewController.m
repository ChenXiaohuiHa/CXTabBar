//
//  ViewController.m
//  CXTabBar
//
//  Created by 陈晓辉 on 2018/9/17.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "ViewController.h"
#import "SubTabBar.h"
#import "CXTabBarController.h"

/**r、g、b为整数，alpha为0-1之间的数 */
#define RGB_Alpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** UITableView */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}
#pragma mark ---------- 表控件展示 ----------
- (void)createTableView {
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.sectionHeaderHeight = 40;
    [self.view addSubview:table];
    self.tableView = table;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dic = self.dataArray[section];
    NSArray *arr = dic[@"arr"];
    return arr.count;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    //设置区头文字属性
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    headerView.textLabel.textAlignment = NSTextAlignmentCenter;
    headerView.textLabel.textColor = [UIColor orangeColor];
    headerView.textLabel.font = [UIFont systemFontOfSize:16];
    headerView.backgroundColor = [UIColor lightGrayColor];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDictionary *dic = self.dataArray[section];
    return [NSString stringWithFormat:@"- %@ -",dic[@"title"]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = indexPath.row %2 == 0 ? [UIColor whiteColor]:RGB_Alpha(248, 248, 248, 1);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //每区数据
    NSDictionary *sectionDic = self.dataArray[indexPath.section];
    NSArray *sectionArr = sectionDic[@"arr"];
    //每行数据
    NSDictionary *rowDic = sectionArr[indexPath.row];
    
    //赋值
    NSMutableAttributedString *titleStr = [self markString:[NSString stringWithFormat:@"%ld.",indexPath.row+1]
                                                     color:[UIColor orangeColor]
                                                     fount:[UIFont fontWithName:@"Marker Felt" size:16]];
    //设置中文倾斜
    CGAffineTransform aTransform = CGAffineTransformMake(1, 0, tanf(5 *M_PI /180), 1, 0, 0);//设置反射, 倾斜角度
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize:14].fontName matrix:aTransform];//取得系统字符并设置反射
    UIFont *font = [UIFont fontWithDescriptor:desc size:16];
    [titleStr appendAttributedString:[self markString:[NSString stringWithFormat:@"  %@",rowDic[@"title"]]
                                                color:[UIColor grayColor]
                                                fount:font]];
    cell.textLabel.attributedText = titleStr;
    cell.detailTextLabel.text = rowDic[@"vcName"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) { //系统
        
        NSDictionary *dic_ = self.dataArray[indexPath.section];
        NSArray *arr = [dic_ objectForKey:@"arr"];
        NSDictionary *dic = arr[indexPath.row];
        NSString *VCName = [dic objectForKey:@"vcName"];
        Class class = NSClassFromString(VCName);
        UITabBarController *viewController = [[class alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{ //自定义
        
        //配置信息
        CXTabBarConfig *config = [CXTabBarConfig config];
        [config configNormal];//恢复默认值(测试使用)
        
        if (indexPath.section == 1) {
            
            //1. 设置属性
            if (indexPath.row == 0) {
                
                //默认样式
                config.layoutType = CXConfigLayoutTypeNormal;
            }else if (indexPath.row == 1) {
                
                //只有图片
                config.layoutType = CXConfigLayoutTypeImage;
                //config.imageSize = CGSizeMake(38, 38);//可以自己设置图片大小, 默认 28*28
            }else if (indexPath.row == 2) {
                
                //设置背景颜色
                config.tabBarBackgroundColor = [UIColor orangeColor];
            }else if (indexPath.row == 3) {
                
                //设置字体颜色
                config.titleNorColor = [UIColor blackColor];
                config.titleSelColor = [UIColor redColor];
            }
        }else if (indexPath.section == 2) {
            
            //2. 点击动画
            if (indexPath.row == 0) { //Y 轴旋转
                config.tabBarAnimType = CXConfigTabBarAnimTypeRotationY;
            }else if (indexPath.row == 1) { //缩放动画
                config.tabBarAnimType = CXConfigTabBarAnimTypeScale;
            }else if (indexPath.row == 2) { //放大
                config.tabBarAnimType = CXConfigTabBarAnimTypeBoundsMax;
            }else if (indexPath.row == 3) { //缩小
                config.tabBarAnimType = CXConfigTabBarAnimTypeBoundsMin;
            }
        }
        
        //
        [self presentTabBarControllerWithConfig:config];
    }
}
- (void)presentTabBarControllerWithConfig:(CXTabBarConfig *)config {
    
    //
    NSArray *controllerArr = @[[OneViewController new],[TwoViewController new],[TwoViewController new],[TwoViewController new]];
    NSArray *norImageArr = @[@"menu-message-normal",@"menu-contact-normal",@"menu-more-normal",@"menu-message-normal"];
    NSArray *selImageArr = @[@"menu-message-down",@"menu-contact-down",@"menu-more-down",@"menu-message-down",];
    NSArray *titleArr = @[@"oneVC",@"twoVC",@"threeVC",@"fourVC"];
    //
    CXTabBarController *tabBarController = [[CXTabBarController alloc] initWithTabBarControllers:controllerArr norImageArray:norImageArr selImageArray:selImageArr titleArray:titleArr tabBarConfig:config];
    [self presentViewController:tabBarController animated:YES completion:nil];
}


//MARK: 富文本
- (NSMutableAttributedString *)markString:(NSString *)string color:(UIColor *)color fount:(UIFont *)font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    
    return attributedString;
}

#pragma mark ---------- 数据源 ----------
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{@"arr":@[@{@"vcName":@"BasedUsingTabBar",@"title":@"默认 tabBar(图片+文字)"},
                                  @{@"vcName":@"SpringAnimationTabBar",@"title":@"动画"}],
                         @"title":@"系统~使用方法"},
                       
                       @{@"arr":@[@{@"title":@"默认 tabBar(图片+文字)"},
                                  @{@"title":@"只有图片"},
                                  @{@"title":@"更改背景颜色"},
                                  @{@"title":@"更改字体颜色"}],
                         @"title":@"自定义~使用方法"},
                       
                       @{@"arr":@[@{@"title":@"Y 轴旋转动画"},
                                  @{@"title":@"缩放"},
                                  @{@"title":@"放缩小动画"}],
                         @"title":@"自定义~动画"},
                       ].copy;
    }
    return _dataArray;
}



@end
