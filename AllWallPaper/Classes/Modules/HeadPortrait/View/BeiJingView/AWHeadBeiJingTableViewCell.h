//
//  AWHeadBeiJingTableViewCell.h
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWHeadPortraitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWHeadBeiJingTableViewCell : UITableViewCell

- (void)loadHeadBeiJingCellSource:(NSArray <AWHeadGroupModel *>*)cellSource;

@end

NS_ASSUME_NONNULL_END
