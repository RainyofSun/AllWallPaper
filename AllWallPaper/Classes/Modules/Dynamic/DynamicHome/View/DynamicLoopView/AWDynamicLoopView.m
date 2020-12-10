//
//  AWDynamicLoopView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicLoopView.h"

@interface AWDynamicLoopView ()<AppCycleScrollviewDelegate>

/** imgBannerView */
@property (nonatomic,strong) AppCycleScrollview *imgBannerView;
/** loopH */
@property (nonatomic,assign,readwrite) CGFloat loopH;
/** loopSource */
@property (nonatomic,strong) NSArray <AWLoopModel *>*loopSource;

@end

@implementation AWDynamicLoopView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.loopH = 250;
        [self setupImgBannerView];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)reloadLoopURLSource:(NSArray<AWLoopModel *> *)loopSource {
    self.loopSource = loopSource;
    NSMutableArray <NSString *>*urlArray = [NSMutableArray arrayWithCapacity:loopSource.count];
    for (AWLoopModel *tempModel in loopSource) {
        [urlArray addObject:tempModel.icon];
    }
    self.imgBannerView.imageURLStringsGroup = urlArray;
}

#pragma mark - AppCycleScrollviewDelegate
- (void)cycleScrollView:(AppCycleScrollview *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark - private methods
- (void)setupImgBannerView {
    self.imgBannerView = [AppCycleScrollview appCycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, self.loopH) shouldInfiniteLoop:YES cycleDelegate:self];
    self.imgBannerView.autoScrollTimeInterval = 3.0f;
    self.imgBannerView.isZoom = NO;
    self.imgBannerView.heightProportion = 1;
    self.imgBannerView.itemWidth = ScreenWidth;
    self.imgBannerView.isHidePageControl = NO;
    [self addSubview:self.imgBannerView];
    self.imgBannerView.placeholderImage = [UIImage imageNamed:@"placeholder_img_2"];
}

@end
