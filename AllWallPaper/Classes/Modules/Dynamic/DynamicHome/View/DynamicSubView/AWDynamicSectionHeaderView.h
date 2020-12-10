//
//  AWDynamicSectionHeaderView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWDynamicSectionHeaderView : UITableViewHeaderFooterView

/** sectionH */
@property (nonatomic,assign,readonly) CGFloat sectionH;

- (void)reloadSectionTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
