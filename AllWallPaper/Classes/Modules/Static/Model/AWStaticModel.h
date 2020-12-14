//
//  AWStaticModel.h
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWStaticCellModel : AWBaseModel

/** imageUrl */
@property (nonatomic,strong) NSString *imageUrl;
/** imageUrlSmall */
@property (nonatomic,strong) NSString *imageUrlSmall;

@end

@interface AWStaticModel : AWBaseModel

/** list */
@property (nonatomic,strong) NSArray <AWStaticCellModel *>*list;
/** totalPageCount */
@property (nonatomic,assign) NSInteger totalPageCount;

@end

NS_ASSUME_NONNULL_END
