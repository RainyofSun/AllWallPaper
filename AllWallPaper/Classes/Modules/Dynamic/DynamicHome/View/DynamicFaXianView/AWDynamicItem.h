//
//  AWDynamicItem.h
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWDynamicItem : NSObject<UIDynamicItem>

@property (nonatomic, readwrite) CGPoint center;
@property (nonatomic, readonly) CGRect bounds;
@property (nonatomic, readwrite) CGAffineTransform transform;

@end

NS_ASSUME_NONNULL_END
