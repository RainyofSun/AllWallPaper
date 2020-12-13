//
//  AWDynamicDiscoverView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicDiscoverView.h"
#import "AWDynamicSliderBar.h"
#import "AWDiscoverCollectionView.h"

@interface AWDynamicDiscoverView ()<UIScrollViewDelegate>

/** topBar */
@property (nonatomic,strong) AWDynamicSliderBar *topBar;
/**mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** viewSource */
@property (nonatomic,strong) NSMutableArray *viewSource;

@end

@implementation AWDynamicDiscoverView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.mainScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topBar];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadTopSliderTitles:(NSArray<NSString *> *)titleSource {
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * titleSource.count, 0);
    [self.topBar loadSliderBarTitleSource:titleSource];
}

- (void)addFirstDiscoverView:(UIView *)discoverView {
    [self.mainScrollView addSubview:discoverView];
    [self.viewSource addObject:@(0)];
}

- (CGFloat)discoverTopbarHight {
    return self.topBar.mj_h;
}

#pragma mark - 消息透传
- (void)switchTopSliderBarItem:(NSNumber *)senderTag {
    if ([self.viewSource containsObject:senderTag]) {
        if (self.discoverDelegate != nil && [self.discoverDelegate respondsToSelector:@selector(reloadOldDiscoverViewData:)]) {
            [self.discoverDelegate reloadOldDiscoverViewData:senderTag.integerValue];
        }
    } else {
        if (self.discoverDelegate != nil && [self.discoverDelegate respondsToSelector:@selector(addNewDiscoverView:)]) {
            [self.viewSource addObject:senderTag];
            [self.mainScrollView addSubview:[self.discoverDelegate addNewDiscoverView:senderTag.integerValue]];
        }
    }
    [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth * senderTag.integerValue, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

/**
*  滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
*/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    FLOG(@"不是人为拖拽scrollView导致滚动完毕");
    
}

/**
 *  滚动完毕就会调用（如果是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    FLOG(@"人为拖拽scrollView导致滚动完毕");
    NSInteger x = scrollView.contentOffset.x / ScreenWidth;
    [self.topBar switchSliderIndex:x];
}

#pragma mark - private methods
- (void)setupUI {
    
    self.mainScrollView = [[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.mainScrollView.delegate = self;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mainScrollView];
    
    [self addSubview:self.topBar];
}

#pragma mark - lazy
- (AWDynamicSliderBar *)topBar {
    if (!_topBar) {
        _topBar = [[AWDynamicSliderBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    }
    return _topBar;
}

- (NSMutableArray *)viewSource {
    if (!_viewSource) {
        _viewSource = [NSMutableArray array];
    }
    return _viewSource;
}

@end
