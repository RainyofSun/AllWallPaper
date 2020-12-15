//
//  AWHeadPortaritDetailViewModel.h
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWHeadPortaritDetailViewModel : AWBaseViewModel

/** dataIndex */
@property (nonatomic,assign) NSInteger dataIndex;
/** viewStyle */
@property (nonatomic,assign) NSInteger viewStyle;

- (void)loadHeadPortaritDetailView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
