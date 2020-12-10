//
//  AWDynamicMainView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AWLoopModel;
@class AWFenLeiModel;

@interface AWDynamicMainView : UIView

- (void)reloadLoopSource:(NSArray <AWLoopModel *>*)loopSource;
- (void)reloadFenleiSource:(NSArray <AWFenLeiModel *>*)fenLeiSource;

@end

NS_ASSUME_NONNULL_END
