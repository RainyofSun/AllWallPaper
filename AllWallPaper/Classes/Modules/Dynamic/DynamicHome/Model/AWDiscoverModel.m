//
//  AWDiscoverModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDiscoverModel.h"

@implementation AWDiscoverCellModel

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

@end

@implementation AWDiscoverModel

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"AWDiscoverCellModel"};
}

@end
