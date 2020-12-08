//
//  UIButton+CustomBtn.m
//  MeiPian
//
//  Created by 刘冉 on 2019/8/17.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "UIButton+CustomBtn.h"

@implementation UIButton (CustomBtn)

//蓝色箭头的返回按钮
+ (UIButton *)newBackArrowNavButtonWithTarget:(id)target action:(SEL)action {
    return  [UIButton newcustomButtonWithTarget:target action:action normalImage:[UIImage imageNamed:@"retBtnNormal"] highlightedImage:[UIImage imageNamed:@"retBtnClicked"] size:CGSizeMake(45, 45)];
}

+ (UIButton *)newcustomButtonWithTarget:(id)target action:(SEL)action normalImage:(UIImage*)normalImage highlightedImage:(UIImage*)highlightedImage size:(CGSize)size {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [rightButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    if (normalImage) {
        [rightButton setImage:normalImage forState:UIControlStateNormal];
    }
    if (highlightedImage) {
        [rightButton setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    if (action && target) {
        [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return rightButton;
}

- (void)changeButtonImgTopAndTextBottom:(CGFloat)distance {
    CGFloat interval = distance ? distance : 1.0;
    CGSize imageSize = self.imageView.bounds.size;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval, -(imageSize.width), 0, 0)];
    CGSize titleSize = self.titleLabel.bounds.size;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width))];
}

- (void)changeButtonImgRightAndTextLeft:(CGFloat)distance {
    CGFloat interval = distance ? distance : 1.0;
    CGSize imageSize = self.imageView.bounds.size;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, (imageSize.width + interval))];
    CGSize titleSize = self.titleLabel.bounds.size;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, (titleSize.width + interval), 0, 0)];
}

@end
