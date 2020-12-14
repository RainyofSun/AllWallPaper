//
//  AWStaticLocalDataTool.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWStaticLocalDataTool.h"
#import "AWStaticModel.h"

@interface AWStaticLocalDataTool ()

/** fileNameArray */
@property (nonatomic,strong) NSArray <NSString *>*fileNameArray;
/** localSource */
@property (nonatomic,strong) NSMutableArray <AWStaticCellModel *>*localSource;

@end

@implementation AWStaticLocalDataTool

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
        [self resetDefaultPage];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (NSArray<NSString *> *)discoverTopSliderBarTitle {
    return @[@"喵斯快跑",@"热门推荐",@"秋天的第一张壁纸",@"123悟空都来排排站",@"王者荣耀",@"男神女神",@"安琪baby",
             @"樱岛麻衣",@"小清新三格动漫",@"拉克丝",@"鬼灭之刃",@"你的名字",@"天气之子",@"偷看手机",@"陈情令"];
}

- (void)requestLocalPaperData:(NSInteger)dataNameIndex dataBlock:(void (^)(id _Nonnull, BOOL))valueBlock loadingDataType:(AWLoadingType)loadType {
    [self requestLocalPaperDataName:self.fileNameArray[dataNameIndex] dataBlock:valueBlock loadingDataType:loadType];
}

- (void)requestLocalPaperDataName:(NSString *)dataName dataBlock:(void (^)(id _Nonnull, BOOL))valueBlock loadingDataType:(AWLoadingType)loadType {
    NSInteger tempPage = 0;
    if (loadType == AWLoadingType_More) {
        tempPage = self.page + 1;
    } else {
        [self resetDefaultPage];
    }
    FLOG(@"加载页数 %ld 记录页数 %ld 加载类目 %@",(long)tempPage,(long)self.page,dataName);
    self.loadingType = loadType;
    __block NSArray <AWStaticCellModel *>* tempArray = nil;
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:[NSString stringWithFormat:@"%@%ld",dataName,tempPage] localData:^(id  _Nonnull responseObject) {
        AWStaticModel *pageModel = [AWStaticModel modelWithDictionary:(NSDictionary *)responseObject];
        tempArray = pageModel.list;
        weakSelf.loadingType == AWLoadingType_More ? weakSelf.page ++ : [weakSelf.localSource removeAllObjects];
        if (weakSelf.page == (pageModel.totalPageCount - 1)) {
            weakSelf.isResetNoMoreData = YES;
        }
        [weakSelf.localSource addObjectsFromArray:tempArray];
        if (valueBlock) {
            valueBlock(weakSelf.localSource,weakSelf.isResetNoMoreData);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

- (void)resetDefaultPage {
    self.page = 0;
    self.isResetNoMoreData = NO;
    [self removeLocalCache];
}

- (void)removeLocalCache {
    [self.localSource removeAllObjects];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.fileNameArray = @[@"hotS",@"new",@"fengJing",@"jianZhu",@"renWu",@"jingXuan",@"animal",@"yiShu",@"xuanKu",];
}

#pragma mark - lazy
- (NSMutableArray<AWStaticCellModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

@end
