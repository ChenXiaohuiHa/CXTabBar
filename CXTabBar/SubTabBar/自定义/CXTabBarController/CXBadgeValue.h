//
//  CXBadgeValue.h
//  TabBar(标签栏)
//
//  Created by 陈晓辉 on 2018/8/8.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CXBadgeValueType) {
    CXBadgeValueTypePoint, //点
    CXBadgeValueTypeNew, //new
    CXBadgeValueTypeNumber, //数值
};
@interface CXBadgeValue : UIView

/** badgeL */
@property (nonatomic, strong) UILabel *badgeL;
/** 标记类型 */
@property (nonatomic, assign) CXBadgeValueType type;

@end
