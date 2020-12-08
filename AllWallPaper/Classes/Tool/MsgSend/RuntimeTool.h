//
//  RuntimeTool.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/28.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeTool : NSObject

/**
 获取类的元类
 
 @param childClass 目标类别
 @return 返回元类
 */
+(Class)getMetaClassWithChildClass:(Class)childClass;

/**
 对一个类添加对象方法
 
 @param class 目标类
 @param methodSel 获取方法名的SEL
 @param impMethodSel 实现方法的SEL用于获取实现方法的IMP
 */
+(void)addMethodWithClass:(Class)class withMethodSel:(SEL)methodSel withImpMethodSel:(SEL)impMethodSel;

@end

NS_ASSUME_NONNULL_END
