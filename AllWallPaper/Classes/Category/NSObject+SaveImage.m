//
//  NSObject+SaveImage.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "NSObject+SaveImage.h"

@implementation NSObject (SaveImage)

#pragma mark 保存图片
- (void)saveImageToPhotos:(UIImage*)savedImage {
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

#pragma mark 系统的完成保存图片的方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    NSString *msg = nil ;
    if (error != NULL) {
        msg = @"保存图片失败" ;
        [MBHUDToastManager showBriefAlert:@"图片保存失败"];
    } else {
        msg = @"保存图片成功" ;
        [MBHUDToastManager showBriefAlert:@"下载完成,图片保存至相册"];
    }
}

@end
