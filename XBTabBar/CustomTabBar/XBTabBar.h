//
//  XBTabBar.h
//  XBTabBar
//
//  Created by guoxb on 15/9/24.
//  Copyright (c) 2015年 guoxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XBTabBar;

@protocol XBTabBarDelegate <NSObject>

@optional
- (void)tabBar:(XBTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
/**
 ** 自定义
 **/
- (void)changeViewController;

@end

@interface XBTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<XBTabBarDelegate> delegate;
@property (nonatomic, weak) UIButton *plusButton;

@end
