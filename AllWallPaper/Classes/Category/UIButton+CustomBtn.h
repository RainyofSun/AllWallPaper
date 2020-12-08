//
//  UIButton+CustomBtn.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/17.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CustomBtn)

/// 初始化的返回按钮
+ (UIButton *)newBackArrowNavButtonWithTarget:(id)target action:(SEL)action;
/// 自定义图片按钮
+ (UIButton *)newcustomButtonWithTarget:(id)target action:(SEL)action normalImage:(UIImage*)normalImage highlightedImage:(UIImage*)highlightedImage size:(CGSize)size;
/// 调整图片文字位置(图上文字下)
- (void)changeButtonImgTopAndTextBottom:(CGFloat)distance;
/// 调整图片文字位置(图右文字左) 间隔默认为1
- (void)changeButtonImgRightAndTextLeft:(CGFloat)distance;

@end

NS_ASSUME_NONNULL_END
