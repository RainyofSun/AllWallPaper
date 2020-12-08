//
//  UIViewController+Navigation.m
//  MeiPian
//
//  Created by 刘冉 on 2019/8/17.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import <objc/runtime.h>
#import "UINavigationController+NavigationBar.h"

@implementation UIViewController (Navigation)

-(UIButton *)setNavigationBackButtonDefault
{
    
    UIButton *backButton = [UIButton newBackArrowNavButtonWithTarget:self action:@selector(navigationBackButtonAction:)];
    [self setNavigationBackButton:backButton];
    return backButton;
}

- (void)setNavigationBackButtonTitle:(NSString *)title {
    if (!title.length) {
        return;
    }
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)setNavigationBackButton:(UIButton *)button
{
    
    [self setNavigationLeftView:button];
}

- (void)navigationBackButtonAction:(UIButton *)sender
{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) { //push方式
            BOOL shouldPop = YES;
            if ([self respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
                shouldPop = [self navigationShouldPopOnBackButton];
            }
            if (shouldPop) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } else { //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)navigationHelpButtonAction:(UIButton *)sender
{
    FLOG(@"帮助按钮被点击");
}
-(void)setNavigationLeftView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]]) {
        [(UIButton *)view setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    // 调整 leftBarButtonItem 在 iOS6 下面的位置
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if([[[UIDevice currentDevice] systemVersion] floatValue]<7.0){
        negativeSpacer.width = 5;  //向右移动5个像素
    }else{
        negativeSpacer.width = -6;  //向左移动6个像素
    }
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];
}

- (void)setNavigationRightView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]]) {
        [(UIButton *)view setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    // 调整 rightBarButtonItem 在 iOS6 下面的位置
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if([[[UIDevice currentDevice] systemVersion] floatValue]<7.0){
        negativeSpacer.width = 5;  //向左移动5个像素
    }else{
        negativeSpacer.width = -5;  //向右移动5个像素
    }
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, buttonItem];
    
}

-(void)setNavigationRightViews:(NSArray *)views
{
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    parentView.backgroundColor = [UIColor clearColor];
    parentView.clipsToBounds = YES;
    
    [self setNavigationRightView:parentView];
    
    UIView *view1 = [views objectAtIndex:0];
    UIView *view2 = [views objectAtIndex:1];
    [parentView addSubview:view1];
    [parentView addSubview:view2];
    
    CGRect parentFrame = parentView.frame;
    CGRect view1Frame = view1.frame;
    CGRect view2Frame = view1.frame;
    
    view2Frame.origin.x = parentFrame.size.width-view2Frame.size.width;
    view2Frame.origin.y = (parentFrame.size.height-view2Frame.size.height)/2;
    view1Frame.origin.x = view2Frame.origin.x-view1Frame.size.width;
    view1Frame.origin.y = view2Frame.origin.y;
    
    view1.frame = view1Frame;
    view2.frame = view2Frame;
}

- (void)setNavigationBackgroudImg:(NSString *)img {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:img] forBarMetrics:UIBarMetricsDefault];
    if (img.length) {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    } else {
        [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:RGB(237,239,245)]];
    }
}

-(void)setNavigationTitleView:(UIView *)view
{
    self.navigationItem.titleView = view;
    
}
#pragma 扩展属性
- (void)setNavHiden:(BOOL)navHiden {
    self.lsl_prefersNavigationBarHidden = navHiden;
}

- (BOOL)navHiden {
    return self.lsl_prefersNavigationBarHidden;
}

@end
