//
//  NSObject+DataTransformToDict.h
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DataTransformToDict)

- (NSDictionary *)dictionaryForJsonData:(NSData *)jsonData;
- (NSData *)compactFormatDataForDictionary:(NSDictionary *)dicJson;

@end

NS_ASSUME_NONNULL_END
