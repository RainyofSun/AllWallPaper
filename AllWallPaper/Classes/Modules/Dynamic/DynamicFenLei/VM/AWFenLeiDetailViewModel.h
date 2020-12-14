//
//  AWFenLeiDetailViewModel.h
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWFenLeiDetailViewModel : AWBaseViewModel

/** dataIndex */
@property (nonatomic,assign) NSInteger dataIndex;

- (void)loadFenLeiDetailView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
