//
//  AWHeadPortraitModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadPortraitModel.h"

@implementation AWHeadGroupModel

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

@end

@implementation AWHeadPortraitModel

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"imageList":@"AWHeadGroupModel"};
}

@end
