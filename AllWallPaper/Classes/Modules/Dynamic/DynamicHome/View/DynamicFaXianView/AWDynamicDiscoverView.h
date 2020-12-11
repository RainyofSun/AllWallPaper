//
//  AWDynamicDiscoverView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AWDynamicDiscoverDelegate <NSObject>

@optional;
- (UIView *)addNewDiscoverView:(NSInteger)scrollIndex;
- (void)reloadOldDiscoverViewData:(NSInteger)scrollIndex;

@end

@interface AWDynamicDiscoverView : UIView

/** discoverDelegate */
@property (nonatomic,weak) id<AWDynamicDiscoverDelegate> discoverDelegate;

- (void)loadTopSliderTitles:(NSArray <NSString *>*)titleSource;
- (void)addFirstDiscoverView:(UIView *)discoverView;

@end

NS_ASSUME_NONNULL_END
