//
//  UIButton+Networking.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "UIButton+Networking.h"

@implementation UIButton (Networking)

- (void)loadNetworkImg:(NSString *)imgUrl bigPlaceHolder:(BOOL)big {
    NSString *holderImg = big ? @"placeholder_img" : @"placeholder_img_2";
    [self setImageWithURL:[NSURL URLWithString:imgUrl] forState:UIControlStateNormal placeholder:[UIImage imageNamed:holderImg] options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
}

- (void)loadBackgroudNetworkImg:(NSString *)imgUrl bigPlaceHolder:(BOOL)big {
    NSString *holderImg = big ? @"placeholder_img" : @"placeholder_img_2";
    [self setBackgroundImageWithURL:[NSURL URLWithString:imgUrl] forState:UIControlStateNormal placeholder:[UIImage imageNamed:holderImg] options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
}

@end
