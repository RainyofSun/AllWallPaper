//
//  AWCommonCache.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWCommonCache.h"

static AWCommonCache *cache = nil;

@implementation AWCommonCache

+ (instancetype)UserGlobalCache {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!cache) {
            cache = [[AWCommonCache alloc] init];
            cache.collectionArray = [NSMutableArray array];
        }
    });
    return cache;
}

- (void)removeCollectionCache {
    [cache.collectionArray removeAllObjects];
}

@end
