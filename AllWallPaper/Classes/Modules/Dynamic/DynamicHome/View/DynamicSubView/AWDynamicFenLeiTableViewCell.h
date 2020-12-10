//
//  AWDynamicFenLeiTableViewCell.h
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWFenLeiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWDynamicFenLeiTableViewCell : UITableViewCell

- (void)loadFenLeiTableViewCellSource:(NSArray <AWFenLeiModel *>*)cellSource;

@end

NS_ASSUME_NONNULL_END
