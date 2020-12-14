//
//  AWHeadPortraitViewModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadPortraitViewModel.h"
#import "AWHeadPortraitSubViewController.h"
#import "AWStaticSliderBarTitleCollectionViewCell.h"
#import "AWHeadPortraitModel.h"
#import "AWHeadPortraitView.h"
#import "AWHeadBeiJingView.h"

static NSString *HeadPortraitTopSliderBarIndifier = @"HeadPortraitTopSliderBarIndifier";

@interface AWHeadPortraitViewModel ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

/** pageControlView */
@property (nonatomic,strong) XLPageViewController *pageControlView;
/** headView */
@property (nonatomic,strong) AWHeadPortraitView *headView;
/** beiJingView */
@property (nonatomic,strong) AWHeadBeiJingView *beiJingView;
/** selectedItemIndex */
@property (nonatomic,assign) NSInteger selectedItemIndex;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/** localSource */
@property (nonatomic,strong) NSMutableArray <AWHeadPortraitModel *>*localSource;
/** totalSource */
@property (nonatomic,strong) NSMutableDictionary *totalSource;

@end

@implementation AWHeadPortraitViewModel

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
- (void)loadHeadPortraitControl:(UIViewController *)vc {
    [vc addChildViewController:self.pageControlView];
    [vc.view addSubview:self.pageControlView.view];
    [self.pageControlView.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.pageControlView.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:vc.view withOffset:kStatusBarHeight];
    self.pageControlView.delegate = self;
    self.pageControlView.dataSource = self;
    [self.pageControlView registerClass:[AWStaticSliderBarTitleCollectionViewCell class] forTitleViewCellWithReuseIdentifier:HeadPortraitTopSliderBarIndifier];
    self.pageControlView.selectedIndex = self.selectedItemIndex;
    [self requestHeadPortraitLocalData];
}

#pragma mark - XLPageViewControllerDelegate & XLPageViewControllerDataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    AWHeadPortraitSubViewController *subVC = [[AWHeadPortraitSubViewController alloc] initWithNibName:@"AWHeadPortraitSubViewController" bundle:nil];
    index == 0 ? [subVC addPortraitSubView:self.headView] : [subVC addPortraitSubView:self.beiJingView];
    return subVC;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titleArray.count;
}

- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    AWStaticSliderBarTitleCollectionViewCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:HeadPortraitTopSliderBarIndifier forIndex:index];
    return cell;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    // 页面滑动即删除数据源
    [self.localSource removeAllObjects];
    self.selectedItemIndex = index;
    NSArray <AWHeadPortraitModel *>* cacheSource = [self.totalSource objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
    if (cacheSource.count) {
        // 滑动已创建的页面,从缓存中取出数据和已加载的页数
        [self.localSource addObjectsFromArray:cacheSource];
        FLOG(@"切换到已缓存的 %@ vc = %@",self.titleArray[index],[pageViewController cellVCForRowAtIndex:index]);
    } else {
        // 滑动至新页面
        [self requestHeadPortraitLocalData];
        FLOG(@"切换到新创建的 %@ vc = %@",self.titleArray[index],[pageViewController cellVCForRowAtIndex:index]);
    }
}

#pragma mark - private methods
- (void)setDefaultData {
    self.titleArray = @[@"头像",@"背景"];
    self.selectedItemIndex = 0;
}

- (void)requestHeadPortraitLocalData {
    NSString *dataName = self.selectedItemIndex == 0 ? @"touXiang0" : @"beiJing0";
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:dataName localData:^(id  _Nonnull responseObject) {
        [weakSelf.localSource removeAllObjects];
        NSArray <AWHeadPortraitModel *>* tempModelSource = [AWHeadPortraitModel modelArrayWithDictArray:(NSArray *)[responseObject objectForKey:@"list"]];
        [weakSelf.localSource addObjectsFromArray:tempModelSource];
        // 数据更新时，同时更新数据缓存中的数据和已加载的页数
        [weakSelf.totalSource setValue:[weakSelf.localSource copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        if (weakSelf.selectedItemIndex == 0) {
            [weakSelf.headView loadHeadPortraitTableViewSource:weakSelf.localSource];
        } else {
            [weakSelf.beiJingView loadHeadPortraitBeiJingTableViewSource:weakSelf.localSource];
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

- (XLPageViewControllerConfig *)pageControlConfig {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //标题按钮边缘距离
    config.btnDistanceToEdge = 20;
    //标题间距
    config.titleSpace = 20;
    //标题高度
    config.titleViewHeight = 45;
    //标题选中颜色
    config.titleSelectedColor = RGB(34, 34, 34);
    //标题选中字体
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
    //标题正常颜色
    config.titleNormalColor = RGBA(0, 0, 0, 0.8);
    //标题正常字体
    config.titleNormalFont = [UIFont systemFontOfSize:17];
    //阴影颜色
    config.shadowLineColor = RGB(45, 213, 118);
    //阴影宽度
    config.shadowLineWidth = 27;
    //阴影距离边缘位置
    config.shadowLineDistanceToEdge = 5;
    //分割线颜色
    config.separatorLineColor = RGB(238, 238, 238);
    //标题位置
    config.titleViewAlignment = XLPageTitleViewAlignmentLeft;
    
    return config;
}

#pragma mark - lazy
- (XLPageViewController *)pageControlView {
    if (!_pageControlView) {
        _pageControlView = [[XLPageViewController alloc] initWithConfig:[self pageControlConfig]];
    }
    return _pageControlView;
}

- (AWHeadPortraitView *)headView {
    if (!_headView) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"AWHeadPortraitView" owner:nil options:nil] firstObject];
    }
    return _headView;
}

- (AWHeadBeiJingView *)beiJingView {
    if (!_beiJingView) {
        _beiJingView = [[[NSBundle mainBundle] loadNibNamed:@"AWHeadBeiJingView" owner:nil options:nil] firstObject];
    }
    return _beiJingView;
}

- (NSMutableArray<AWHeadPortraitModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

- (NSMutableDictionary *)totalSource {
    if (!_totalSource) {
        _totalSource = [NSMutableDictionary dictionaryWithCapacity:self.titleArray.count];
    }
    return _totalSource;
}

@end
