//
//  AWDynamicLoopView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWLoopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWDynamicLoopView : UIView

/** loopH */
@property (nonatomic,assign,readonly) CGFloat loopH;

- (void)reloadLoopURLSource:(NSArray <AWLoopModel *>*)loopSource;

@end

NS_ASSUME_NONNULL_END
