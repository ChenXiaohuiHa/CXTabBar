//
//  CXTabBarItem.h
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXBadgeValue.h"
#import "CXTabBarConfig.h"

@interface CXTabBarItem : UIView

/** item 图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** item 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** item 角标 */
@property (nonatomic, strong) CXBadgeValue *badgeValue;
/** item 角标内容 */
@property(nonatomic, copy) NSString *badge;
/** item 布局类型 */
@property (nonatomic, assign) CXConfigLayoutType layoutType;

@end
