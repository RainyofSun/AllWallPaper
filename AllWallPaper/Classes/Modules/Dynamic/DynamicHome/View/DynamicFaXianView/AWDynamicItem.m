//
//  AWDynamicItem.m
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicItem.h"

@implementation AWDynamicItem

- (instancetype)init {
    if (self = [super init]) {
        _bounds = CGRectMake(0, 0, 1, 1);
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

@end
