//
//  FWRefreshHeader.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWRefreshHeader.h"

@implementation FWRefreshHeader

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 重写方法
- (void)prepare {
    [super prepare];
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    self.stateLabel.textColor = HexColor(0xB2B2B2);
    self.lastUpdatedTimeLabel.textColor = HexColor(0xB2B2B2);
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
             /** 普通闲置状态 */
            //在这里设置子控件在普通闲置状态的界面展示
            self.stateLabel.text = @"下拉刷新界面";
            break;
        case MJRefreshStatePulling:
            /** 松开就可以进行刷新的状态 */
            //在这里设置子控件在松开就可以进行刷新的状态的界面展示
            self.stateLabel.text = @"松开刷新界面";
            break;
        case MJRefreshStateRefreshing:
            /** 正在刷新中的状态 */
            //在这里设置子控件在正在刷新中的状态的界面展示
            self.stateLabel.text = @"刷新中...";
            break;
        case MJRefreshStateWillRefresh:
            /** 即将要刷新的状态 */
            break;
        case MJRefreshStateNoMoreData:
            /** 没有更多数据了 */
            break;
        default:
            break;
    }
}

@end
