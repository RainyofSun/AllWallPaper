//
//  EGLSBackupMessage.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/28.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "EGLSBackupMessage.h"

@implementation EGLSBackupMessage

-(void)modulesSendMsg:(id)params{
    FLOG(@"备用类的对象方法EGLSBackupMessage");
}

+(void)modulesSendMsg:(id)params{
    FLOG(@"备用类的类方法EGLSBackupMessage");
}

- (void)reloadMallTextBanner:(id)params {
    FLOG(@"备用类---->接收处理刷新商城banner消息 %@",params);
}

- (void)gotoMallPage {
    FLOG(@"备用类---->接收处理返回商城消息");
}

@end
