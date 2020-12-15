//
//  AWDynamicDetailView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AWDynamicDetailDelegate <NSObject>

- (void)downloadWallPaper;

@end

@interface AWDynamicDetailView : UIView

/** paperDownLoadDelegate */
@property (nonatomic,weak) id<AWDynamicDetailDelegate> paperDownLoadDelegate;

- (void)loadDetailPaper:(NSString *)paperUrl;

@end

NS_ASSUME_NONNULL_END
