//
//  AWDynamicSliderBar.m
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicSliderBar.h"

@interface AWDynamicSliderBar ()<UIScrollViewDelegate>

/** sliderScrollView */
@property (nonatomic,strong) UIScrollView *sliderScrollView;
/** btnArray */
@property (nonatomic,strong) NSMutableArray <UIButton *>*btnArray;

@end

@implementation AWDynamicSliderBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.sliderScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    for (UIButton *item in _btnArray) {
        [item removeFromSuperview];
    }
    [self.btnArray removeAllObjects];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadSliderBarTitleSource:(NSArray<NSString *> *)titleSource {
    self.btnArray = [NSMutableArray arrayWithCapacity:titleSource.count];
    [self setupSliderbarItems:titleSource];
}

- (void)switchSliderIndex:(NSInteger)index {
    [self touchTopSliderBar:self.btnArray[index]];
}

- (void)touchTopSliderBar:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self resetTopSliderItemStatus];
    sender.titleLabel.alpha = 1;
    sender.backgroundColor = RGB(201, 231, 254);
    sender.selected = !sender.selected;
    if ((sender.mj_x + sender.mj_w) > ScreenWidth && sender.tag > 1) {
        UIButton *tempSender = self.btnArray[sender.tag - 2];
        [self.sliderScrollView setContentOffset:CGPointMake((tempSender.mj_x + tempSender.mj_w + 30), 0) animated:YES];
    } else {
        [self.sliderScrollView setContentOffset:CGPointZero animated:YES];
    }
    [FLModuleMsgSend sendCumtomMethodMsg:self.superview methodName:@selector(switchTopSliderBarItem:) params:[NSNumber numberWithInteger:sender.tag]];
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
//    self.selectedIndex = scrollView.contentOffset.x / ScreenWidth;
//    [self.topBar switchSliderIndex:self.selectedIndex];
}

#pragma mark - private methods
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.sliderScrollView = [[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.sliderScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.sliderScrollView.delegate = self;
    self.sliderScrollView.bounces = NO;
    self.sliderScrollView.showsVerticalScrollIndicator = NO;
    self.sliderScrollView.showsHorizontalScrollIndicator = NO;
    self.sliderScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.sliderScrollView];
}

- (void)setupSliderbarItems:(NSArray<NSString *> *)titleSource {
    if (self.btnArray.count) {
        return;
    }
    CGFloat distance = 10;
    CGFloat itemH = CGRectGetHeight(self.bounds);
    CGFloat contentSizeW = distance;
    for (NSInteger i = 0; i < titleSource.count; i ++) {
        CGFloat itemW = [titleSource[i] widthForFont:[UIFont systemFontOfSize:17]] + distance * 3;
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = i;
        i != 0 ? item.titleLabel.alpha = 0.8 : 1;
        item.selected = (i == 0);
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        [item setTitle:titleSource[i] forState:UIControlStateNormal];
        [item setTitleColor:RGB(109, 109, 109) forState:UIControlStateNormal];
        [item setTitleColor:RGB(16, 154, 247) forState:UIControlStateSelected];
        item.backgroundColor = item.selected ? RGB(201, 231, 254) : RGB(242, 242, 242);
        item.layer.cornerRadius = itemH/2;
        item.clipsToBounds = YES;
        [item addTarget:self action:@selector(touchTopSliderBar:) forControlEvents:UIControlEventTouchUpInside];
        item.frame = CGRectMake(contentSizeW, 0, itemW, itemH);
        contentSizeW += (itemW + distance * 2);
        [self.sliderScrollView addSubview:item];
        [self.btnArray addObject:item];
    }
    self.sliderScrollView.contentSize = CGSizeMake(contentSizeW, 0);
}

// 重置状态
- (void)resetTopSliderItemStatus {
    for (UIButton *item in self.btnArray) {
        if (item.selected) {
            item.titleLabel.alpha = 0.8;
            item.backgroundColor = RGB(242, 242, 242);
            item.selected = NO;
            break;
        }
    }
}

@end
