//
//  AWHeadPortaritDetailViewModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadPortaritDetailViewModel.h"
#import "AWHeadDetailView.h"
#import "AWBeiJingDetailView.h"

@interface AWHeadPortaritDetailViewModel ()<AWHeadDetailDelegate,AWBeiJingDetailDelegate>

/** headView */
@property (nonatomic,strong) AWHeadDetailView *headView;
/** beiJingView */
@property (nonatomic,strong) AWBeiJingDetailView *beiJingView;
/** localSource */
@property (nonatomic,strong) NSMutableArray <AWStaticCellModel *>*localSource;
/** fileNameArray */
@property (nonatomic,strong) NSArray <NSString *>*fileNameArray0;
/** fileNameArray */
@property (nonatomic,strong) NSArray <NSString *>*fileNameArray1;

@end

@implementation AWHeadPortaritDetailViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadHeadPortaritDetailView:(UIView *)view {
    if (self.viewStyle == 0) {
        self.headView.headDelegate = self;
        [view addSubview:self.headView];
        [self.headView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [self.headView headWallPaperRefresh];
    } else {
        self.beiJingView.beiJingDelegate = self;
        [view addSubview:self.beiJingView];
        [self.beiJingView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [self requestDetailLocalData:AWLoadingType_Normal];
    }
}

#pragma mark - AWHeadDetailDelegate
- (void)pullRefreshPage {
    [self requestDetailLocalData:AWLoadingType_Normal];
}

- (void)dragLoadMore {
    [self requestDetailLocalData:AWLoadingType_More];
}

- (void)didSelectedHeadWallPaper:(AWStaticCellModel *)paperModel {
    [[self.headView nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:paperModel.imageUrl vcName:@"AWDynamicDetailViewController"] animated:YES];
}

#pragma mark - AWBeiJingDetailDelegate
- (void)didSelectedBeiJingPaper:(NSString *)paperUrl {
    [[self.beiJingView nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:paperUrl vcName:@"AWDynamicDetailViewController"] animated:YES];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.fileNameArray0 = @[@"zhiYu",@"qingLvT",@"mengChongT",@"jianYue",@"MingXingT",@"dongMan",
                           @"ouMei",@"qingXin",@"geXing",@"meiNv",@"weiMeiT",@"youQu",@"beiJingT",
                           @"nanSheng",@"keAi",@"tianMei"];
    self.fileNameArray1 = @[@"tianMeiB0",@"anHei0",@"fengJingB0",@"wenYi0"];
}

- (void)requestDetailLocalData:(AWLoadingType)loadType {
    NSInteger tempPage = 0;
    if (loadType == AWLoadingType_More) {
        tempPage = self.page + 1;
    } else {
        tempPage = self.page = 0;
        [self.localSource removeAllObjects];
    }
    self.loadingType = loadType;
    __block NSArray <AWStaticCellModel *>*tempArray = nil;
    NSString *fileName = @"";
    if (self.viewStyle == 0) {
        fileName = [NSString stringWithFormat:@"%@%ld",self.fileNameArray0[self.dataIndex],tempPage];
    } else {
        fileName = self.fileNameArray1[self.dataIndex];
    }
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:fileName localData:^(id  _Nonnull responseObject) {
        AWStaticModel *tempModel = [AWStaticModel modelWithDictionary:(NSDictionary *)responseObject];
        tempArray = tempModel.list;
        loadType == AWLoadingType_More ? weakSelf.page ++ : [weakSelf.localSource removeAllObjects];
        if (weakSelf.page == (tempModel.totalPageCount - 1)) {
            weakSelf.isResetNoMoreData = YES;
            if (weakSelf.viewStyle == 0) {
                [weakSelf.headView resetFooterStatus:MJRefreshStateNoMoreData];
            } else {
                
            }
            [MBHUDToastManager showBriefAlert:@"没有更多数据了"];
        }
        [weakSelf.localSource addObjectsFromArray:tempArray];
        if (weakSelf.viewStyle == 0) {
            [weakSelf.headView loadHeadDetailPaperSource:weakSelf.localSource];
        } else {
            [weakSelf.beiJingView loadBeiJingDetailSource:weakSelf.localSource];
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

#pragma mark - lazy
- (AWHeadDetailView *)headView {
    if (!_headView) {
        _headView = [[AWHeadDetailView alloc] init];
    }
    return _headView;
}

- (AWBeiJingDetailView *)beiJingView {
    if (!_beiJingView) {
        _beiJingView = [[[NSBundle mainBundle] loadNibNamed:@"AWBeiJingDetailView" owner:nil options:nil] firstObject];
    }
    return _beiJingView;
}

- (NSMutableArray<AWStaticCellModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

@end
