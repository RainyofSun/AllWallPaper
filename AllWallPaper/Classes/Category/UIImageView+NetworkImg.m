//
//  UIImageView+NetworkImg.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "UIImageView+NetworkImg.h"

@implementation UIImageView (NetworkImg)

- (void)loadNetworkImg:(NSString *)imgUrl bigPlaceHolder:(BOOL)big {
    NSString *holderImg = big ? @"placeholder_img" : @"placeholder_img_2";
    [self setImageWithURL:[NSURL URLWithString:imgUrl] placeholder:[UIImage imageNamed:holderImg] options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
}

@end
