//
//  AWStaticModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWStaticModel.h"

@implementation AWStaticCellModel

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

@end

@implementation AWStaticModel

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"AWStaticCellModel"};
}

@end
