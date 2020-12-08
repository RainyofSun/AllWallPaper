//
//  RuntimeTool.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/28.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "RuntimeTool.h"

@implementation RuntimeTool

+(Class)getMetaClassWithChildClass:(Class)childClass{
    //转换字符串类别
    const  char * classChar = [NSStringFromClass(childClass) UTF8String];
    //需要char的字符串 获取元类
    return objc_getMetaClass(classChar);
}

+(void)addMethodWithClass:(Class)class withMethodSel:(SEL)methodSel withImpMethodSel:(SEL)impMethodSel{
    //获取实现的方法内容
    Method funtionRealMethod = class_getInstanceMethod(class, impMethodSel);
    //实现方法的IMP
    IMP methodIMP = method_getImplementation(funtionRealMethod);
    //实现方法的类别 返回类型 携带参数 等
    const char * types = method_getTypeEncoding(funtionRealMethod);
    //对目标添加方法
    class_addMethod(class, methodSel, methodIMP, types);
}

@end
