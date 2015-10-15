//
//  XBTabBar.m
//  XBTabBar
//
//  Created by guoxb on 15/9/24.
//  Copyright (c) 2015年 guoxb. All rights reserved.
//

#import "XBTabBar.h"
#import "XBTabBarButton.h"

@interface XBTabBar()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@property (nonatomic, weak) XBTabBarButton *selectedButton;
@end

@implementation XBTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) { // 非iOS7下,设置tabbar的背景
            self.backgroundColor = [UIColor whiteColor];
        }
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, 49)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        // 添加一个加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        plusButton.backgroundColor = [UIColor blueColor];

        plusButton.bounds = CGRectMake(0, 0, 68, 68);
        plusButton.clipsToBounds = YES;
        plusButton.layer.cornerRadius = 34;
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    XBTabBarButton *button = [[XBTabBarButton alloc] init];
    [self addSubview:button];
    // 添加按钮到数组中
    [self.tabBarButtons addObject:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(XBTabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height-10;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    // 按钮的frame数据
    CGFloat buttonH = h;
//    CGFloat buttonW = w / (self.subviews.count-1);
    CGFloat buttonW = w / 5;
    CGFloat buttonY = 4+10;
    
    for (int index = 0; index<self.tabBarButtons.count; index++) {
        // 1.取出按钮
        XBTabBarButton *button = self.tabBarButtons[index];

        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        NSLog(@"%f",buttonX);
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}
@end
