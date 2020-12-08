//
//  UIViewController+Navigation.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/17.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BackButtonHandlerProtocol <NSObject>

@optional
// 重写下面的方法以拦截导航栏返回按钮点击事件，返回 YES 则 pop，NO 则不 pop
-(BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (Navigation)<BackButtonHandlerProtocol>

// 设置回退按钮
-(void)setNavigationBackButton:(UIButton *)button;
// 修改返回按钮文字
-(void)setNavigationBackButtonTitle:(NSString *)title;
// 设置默认回退按钮
-(UIButton *)setNavigationBackButtonDefault;

// 为navigationbar设置左视图
-(void)setNavigationLeftView:(UIView *)view;

// 为navigationbar设置右视图
-(void)setNavigationRightView:(UIView *)view;

// 为navigationbar设置右视图集
-(void)setNavigationRightViews:(NSArray *)views;

// 为navigationbar设置标题视图
-(void)setNavigationTitleView:(UIView *)view;

// 设置navigationbar背景图片
- (void)setNavigationBackgroudImg:(NSString *)img;

//重新方法
- (void)navigationBackButtonAction:(UIButton *)sender;
- (void)navigationHelpButtonAction:(UIButton *)sender;

#pragma 扩展属性
- (void)setNavHiden:(BOOL)navHiden;

- (BOOL)navHiden;

@end

NS_ASSUME_NONNULL_END
