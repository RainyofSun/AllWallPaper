//
//  AWDiscoverModel.h
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWDiscoverCellModel : AWBaseModel

/** smallUrl */
@property (nonatomic,strong) NSString *smallUrl;
/** visitUrl */
@property (nonatomic,strong) NSString *visitUrl;

@end

@interface AWDiscoverModel : AWBaseModel

/** totalPageCount */
@property (nonatomic,assign) NSInteger totalPageCount;
/** list */
@property (nonatomic,strong) NSArray <AWDiscoverCellModel *>*list;

@end

NS_ASSUME_NONNULL_END
