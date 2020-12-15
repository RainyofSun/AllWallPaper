//
//  AWFenLeiDetailViewModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWFenLeiDetailViewModel.h"
#import "AWFenLeiDetailView.h"

@interface AWFenLeiDetailViewModel ()<AWFenLeiDetailViewDelegate>

/** detailView */
@property (nonatomic,strong) AWFenLeiDetailView *detailView;
/** localSource */
@property (nonatomic,strong) NSMutableArray <AWDiscoverCellModel *>*localSource;
/** fileNameArray */
@property (nonatomic,strong) NSArray <NSString *>*fileNameArray;

@end

@implementation AWFenLeiDetailViewModel

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
- (void)loadFenLeiDetailView:(UIView *)view {
    [view addSubview:self.detailView];
    self.detailView.wallPaperDelegate = self;
    [self.detailView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.detailView wallPaperStartRefresh];
}

#pragma mark - AWFenLeiDetailViewDelegate
- (void)pullRefreshPage {
    [self.detailView resetFooterStatus:MJRefreshStateIdle];
    [self requestFenLeiLoadData:AWLoadingType_Normal];
}

- (void)dragLoadMore {
    [self requestFenLeiLoadData:AWLoadingType_More];
}

- (void)didSelectedWallPaper:(AWDiscoverCellModel *)paperModel {
    [[self.detailView nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:paperModel.visitUrl vcName:@"AWDynamicDetailViewController"] animated:YES];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.fileNameArray = @[@"xuanKuH",@"nanShenH",@"mengChongH",@"mingXingH",@"qingLv",@"weiMeiH",@"wenZi",@"fengJingH"];
}

- (void)requestFenLeiLoadData:(AWLoadingType)loadType {
    NSInteger tempPage = 0;
    if (loadType == AWLoadingType_More) {
        tempPage = self.page + 1;
    } else {
        tempPage = self.page = 0;
        [self.localSource removeAllObjects];
    }
    self.loadingType = loadType;
    __block NSArray <AWDiscoverCellModel *>*tempCellModelArray = nil;
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:[NSString stringWithFormat:@"%@%ld",self.fileNameArray[self.dataIndex],self.page] localData:^(id  _Nonnull responseObject) {
        AWDiscoverModel *tempModel = [AWDiscoverModel modelWithDictionary:(NSDictionary *)responseObject];
        loadType == AWLoadingType_More ? weakSelf.page ++ : [weakSelf.localSource removeAllObjects];
        tempCellModelArray = tempModel.list;
        if (weakSelf.page == (tempModel.totalPageCount - 1)) {
            weakSelf.isResetNoMoreData = YES;
            [MBHUDToastManager showBriefAlert:@"没有更多数据了"];
            [weakSelf.detailView resetFooterStatus:MJRefreshStateNoMoreData];
        }
        [weakSelf.localSource addObjectsFromArray:tempCellModelArray];
        [weakSelf.detailView loadFenLeiWallPaperSource:weakSelf.localSource];
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

#pragma mark - lazy
- (AWFenLeiDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[AWFenLeiDetailView alloc] init];
    }
    return _detailView;
}

- (NSMutableArray<AWDiscoverCellModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

@end
