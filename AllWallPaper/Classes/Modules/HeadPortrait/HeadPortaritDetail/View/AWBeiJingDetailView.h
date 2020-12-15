//
//  AWBeiJingDetailView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWStaticModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AWBeiJingDetailDelegate <NSObject>

@optional;
- (void)didSelectedBeiJingPaper:(NSString *)paperUrl;

@end

@interface AWBeiJingDetailView : UIView

/** beiJingDelegate */
@property (nonatomic,weak) id<AWBeiJingDetailDelegate> beiJingDelegate;

- (void)loadBeiJingDetailSource:(NSArray <AWStaticCellModel *>*)paperSource;

@end

NS_ASSUME_NONNULL_END
