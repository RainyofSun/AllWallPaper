//
//  AWStaticLocalDataTool.h
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWStaticLocalDataTool : AWBaseViewModel

- (NSArray <NSString *>*)discoverTopSliderBarTitle;
- (void)requestLocalPaperData:(NSInteger)dataNameIndex dataBlock:(void(^)(id responseObject,BOOL isNoMoreData))valueBlock loadingDataType:(AWLoadingType)loadType;
- (void)requestLocalPaperDataName:(NSString *)dataName dataBlock:(void (^)(id responseObject,BOOL isNoMoreData))valueBlock loadingDataType:(AWLoadingType)loadType;
- (void)resetDefaultPage;
- (void)removeLocalCache;

@end

NS_ASSUME_NONNULL_END
