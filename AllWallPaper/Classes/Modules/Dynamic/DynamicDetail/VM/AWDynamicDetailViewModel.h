//
//  AWDynamicDetailViewModel.h
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWDynamicDetailViewModel : AWBaseViewModel

/** downLoadUrl */
@property (nonatomic,strong) NSString *downLoadUrl;

- (void)loadDynamicDetailView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
