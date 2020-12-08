//
//  NSObject+DataTransformToDict.m
//  FashionWallPaper
//
//  Created by 刘冉 on 2020/11/28.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "NSObject+DataTransformToDict.h"

@implementation NSObject (DataTransformToDict)

- (NSDictionary *)dictionaryForJsonData:(NSData *)jsonData {
    if (![jsonData isKindOfClass:[NSData class]] || jsonData.length < 1) {
        return nil;
    }
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    if (![jsonObj isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [NSDictionary dictionaryWithDictionary:(NSDictionary *)jsonObj];
}

- (NSData *)compactFormatDataForDictionary:(NSDictionary *)dicJson {
    if (![dicJson isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:0 error:nil];
    if (![jsonData isKindOfClass:[NSData class]]) {
        return nil;
    }
    return jsonData;
}

@end
