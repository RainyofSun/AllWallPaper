//
//  FWRefreshFooter.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWRefreshFooter.h"

@implementation FWRefreshFooter

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)prepare {
    [super prepare];
    self.triggerAutomaticallyRefreshPercent = 0.3;
}

@end
