//
//  AWCommonCache.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWCommonCache : NSObject

+ (instancetype)UserGlobalCache;
- (void)removeCollectionCache;

/** duanYuCollection */
@property (nonatomic,strong) NSMutableArray <NSDictionary *>*collectionArray;

@end

NS_ASSUME_NONNULL_END
