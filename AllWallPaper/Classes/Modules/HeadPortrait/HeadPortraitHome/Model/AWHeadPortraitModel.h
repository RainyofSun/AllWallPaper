//
//  AWHeadPortraitModel.h
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWHeadGroupModel : AWBaseModel

/** imageUrl */
@property (nonatomic,strong) NSString *imageUrl;
/** imageUrlSmall */
@property (nonatomic,strong) NSString *imageUrlSmall;

@end

@interface AWHeadPortraitModel : AWBaseModel

/** groupName */
@property (nonatomic,strong) NSString *groupName;
/** imageList */
@property (nonatomic,strong) NSArray <AWHeadGroupModel *>*imageList;

@end

NS_ASSUME_NONNULL_END
