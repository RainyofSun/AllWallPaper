//
//  AWHeadBeiJingView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AWHeadPortraitModel;

@interface AWHeadBeiJingView : UIView

- (void)loadHeadPortraitBeiJingTableViewSource:(NSArray<AWHeadPortraitModel *> *)headSource;

@end

NS_ASSUME_NONNULL_END
