//
//  AWDynamicSliderBar.h
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWDynamicSliderBar : UIView

- (void)loadSliderBarTitleSource:(NSArray <NSString *>*)titleSource;
- (void)switchSliderIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
