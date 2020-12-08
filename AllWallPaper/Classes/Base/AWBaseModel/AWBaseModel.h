//
//  AWBaseModel.h
//  AllWallPaper
//
//  Created by EGLS_BMAC on 2020/12/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWBaseModel : NSObject

/**
 * 字典数组转模型数组
 */
+(NSMutableArray *)modelArrayWithDictArray:(NSArray*)response;

/**
 * 字典转模型
 */
+(instancetype)modelWithDictionary:(NSDictionary*)dictionary;

/**
 * 模型包含模型数组
 */
+(void)setUpModelClassInArrayWithCotainDict:(NSDictionary*)dict;

/**
 * 字典数组转模型数组
 * @param dict 模型包含模型数组 格式为key－字段名字 value - [被包含的类名]
 */
+(NSMutableArray *)modelArrayWithDictArray:(NSArray*)response containDict:(NSDictionary*)dict;

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)modelKeyValues;

@end

NS_ASSUME_NONNULL_END
