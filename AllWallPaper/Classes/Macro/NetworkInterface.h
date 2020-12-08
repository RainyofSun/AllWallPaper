//
//  NetworkInterface.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#ifndef NetworkInterface_h
#define NetworkInterface_h

#define HOSTURL @"https://www.bizhiduoduo.com/"

/// 首页-分类-更多 res -> pic 单纯图片 video 视频 all 全部
//https://www.bizhiduoduo.com/wallpaper/wplist.php?classid=1005&labelid=1241&type=get_class_list
#define Classify_more(classid,labelid,page)   [NSString stringWithFormat:@"%@wallpaper/wplist.php?classid=%@&labelid=%@&type=get_class_list&res=pic&pg=%ld",HOSTURL,classid,labelid,page]

#endif /* NetworkInterface_h */
