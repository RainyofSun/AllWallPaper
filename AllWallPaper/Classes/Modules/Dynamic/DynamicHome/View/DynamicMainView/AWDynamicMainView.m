//
//  AWDynamicMainView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicMainView.h"
#import "AWDynamicLoopView.h"
#import "AWDynamicSectionHeaderView.h"
#import "AWDynamicFenLeiTableViewCell.h"
#import "AWDynamicDiscoverTableViewCell.h"
#import "AWDynamicItem.h"

/*f(x, d, c) = (x * d * c) / (d + c * x)
where,
x – distance from the edge
c – constant (UIScrollView uses 0.55)
d – dimension, either width or height*/

static NSString *DynamicSectionHeader = @"DynamicSectionHeader";
static NSString *DynamicFenLeiCell    = @"DynamicFenLeiCell";
static NSString *DynamicDiscoverCell  = @"DynamicDiscoverCell";

static CGFloat rubberBandDistance(CGFloat offset, CGFloat dimension) {
    
    const CGFloat constant = 0.55f;
    CGFloat result = (constant * fabs(offset) * dimension) / (dimension + constant * fabs(offset));
    // The algorithm expects a positive offset, so we have to negate the result if the offset was negative.
    return offset < 0.0f ? -result : result;
}

@interface AWDynamicMainView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dynamicTableView;
/** loopView */
@property (nonatomic,strong) AWDynamicLoopView *loopView;
/** fenLeiSource */
@property (nonatomic,strong) NSArray <AWFenLeiModel *>*fenLeiSource;
/** canScroll */
@property (nonatomic,assign) BOOL canScroll;

/** panGes */
@property (nonatomic,strong) UIPanGestureRecognizer *panGes;

/** currentScrollY */
@property (nonatomic,assign) CGFloat currentScrollY;
/** isVertical */
@property (nonatomic,assign) BOOL isVertical;

// 弹性&惯性动画
/** dynamicItem */
@property (nonatomic,strong) AWDynamicItem *dynamicItem;
/** animator */
@property (nonatomic,strong) UIDynamicAnimator *animator;
/** decelerationBehavior */
@property (nonatomic,weak) UIDynamicItemBehavior *decelerationBehavior;
/** springBehavior */
@property (nonatomic,weak) UIAttachmentBehavior *springBehavior;

@end

@implementation AWDynamicMainView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDefaultStatus];
    [self setupTableView];
}

- (void)dealloc {
    [self.animator removeAllBehaviors];
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)reloadLoopSource:(NSArray<AWLoopModel *> *)loopSource {
    [self.loopView reloadLoopURLSource:loopSource];
}

- (void)reloadFenleiSource:(NSArray<AWFenLeiModel *> *)fenLeiSource {
    self.fenLeiSource = fenLeiSource;
    [self.dynamicTableView reloadData];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat currentY = [recognizer translationInView:self].y;
        CGFloat currentX = [recognizer translationInView:self].x;
        if (currentY == 0.0) {
            return YES;
        } else {
            if (fabs(currentX)/currentY >= 5.0) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    return NO;
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.currentScrollY = self.dynamicTableView.contentOffset.y;
            CGFloat currentY    = [recognizer translationInView:self].y;
            CGFloat currentX    = [recognizer translationInView:self].x;
            if (currentY == 0.0) {
                self.isVertical = NO;
            } else {
                if (fabs(currentX)/currentY >= 5.0) {
                    self.isVertical = NO;
                } else {
                    self.isVertical = YES;
                }
            }
            [self.animator removeAllBehaviors];
            break;
        case UIGestureRecognizerStateChanged:
        {
            //locationInView:获取到的是手指点击屏幕实时的坐标点；
            //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
            if (self.isVertical) {
                // 往上滑为负数,往下滑是正数
                CGFloat currentY = [recognizer translationInView:self].y;
                [self controlScrollForVertical:currentY AndState:UIGestureRecognizerStateChanged];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (self.isVertical) {
                self.dynamicItem.center = self.bounds.origin;
                // velocity 是在手指结束的时候获取的竖直方向的手势速度
                CGPoint velocity = [recognizer velocityInView:self];
                UIDynamicItemBehavior *inertialBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicItem]];
                [inertialBehavior addLinearVelocity:CGPointMake(0, velocity.y) forItem:self.dynamicItem];
                // 尝试取2.0比较像系统的效果
                inertialBehavior.resistance = 2.0;
                __block CGPoint lastCenter = CGPointZero;
                WeakSelf;
                inertialBehavior.action = ^{
                    if (weakSelf.isVertical) {
                        // 得到每次移动的距离
                        CGFloat currentY = weakSelf.dynamicItem.center.y - lastCenter.y;
                        [weakSelf controlScrollForVertical:currentY AndState:UIGestureRecognizerStateChanged];
                    }
                    lastCenter = weakSelf.dynamicItem.center;
                };
                [self.animator addBehavior:inertialBehavior];
                self.decelerationBehavior = inertialBehavior;
            }
        }
            break;
        default:
            break;
    }
    // 保证每次只是移动的距离,不是从头一直移动的距离
    [recognizer setTranslation:CGPointZero inView:self];
}

#pragma mark - UIDynamicAnimatorDelegate
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
//    [self.articleView.listTableView customSliderBarDisAlphaAnimation];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 60 : ScreenHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AWDynamicFenLeiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicFenLeiCell];
        [cell loadFenLeiTableViewCellSource:self.fenLeiSource];
        return cell;
    } else {
        AWDynamicDiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicDiscoverCell];
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AWDynamicSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:DynamicSectionHeader];
    [headerView reloadSectionTitle:(section == 0 ? @"分类" : @"发现")];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.dynamicTableView) {
        return;
    }
    // 当前偏移量
    CGFloat yOffset = scrollView.contentOffset.y;
    // 临界点偏移量
    CGFloat criticalOffset = self.loopView.loopH + 40 * 2 + 60;
    self.canScroll = (yOffset >= criticalOffset);
    self.dynamicTableView.scrollEnabled = !self.canScroll;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:[NSNumber numberWithBool:self.canScroll]];
}

#pragma mark - private methods
- (void)setDefaultStatus {
    self.canScroll = YES;
}

- (void)setupTableView {
    if (@available(iOS 11.0, *)) {
        self.dynamicTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.dynamicTableView.delegate = self;
    self.dynamicTableView.dataSource = self;
    self.dynamicTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.loopView.loopH)];
    [self.dynamicTableView.tableHeaderView addSubview:self.loopView];
    [self.loopView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.dynamicTableView registerNib:[UINib nibWithNibName:@"AWDynamicSectionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:DynamicSectionHeader];
    [self.dynamicTableView registerClass:[AWDynamicFenLeiTableViewCell class] forCellReuseIdentifier:DynamicFenLeiCell];
    [self.dynamicTableView registerClass:[AWDynamicDiscoverTableViewCell class] forCellReuseIdentifier:DynamicDiscoverCell];
    self.dynamicTableView.scrollEnabled = NO;
    
    self.panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    self.panGes.delegate = self;
    [self addGestureRecognizer:self.panGes];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    self.animator.delegate = self;
    self.dynamicItem = [[AWDynamicItem alloc] init];
}

//控制上下滚动的方法
- (void)controlScrollForVertical:(CGFloat)detal AndState:(UIGestureRecognizerState)state {
    /*
    // 判断是MainScrollView滚动还是子ScrollView滚动,detal为手指移动的距离
    if (self.dynamicTableView.contentOffset.y >= self.loopView.loopH) {
        [self.articleView.listTableView customSliderBarShowAlphaAnimation];
        CGFloat offsetY = self.articleView.listTableView.contentOffset.y - detal;
        if (offsetY < 0) {
            // 当子ScrollView的contentOffSet小于0之后就b不再移动子ScrollView,而要移动mainScrollView
            offsetY = 0;
            self.mainScrollView.contentOffset = CGPointMake(0, self.mainScrollView.contentOffset.y - detal);
        } else if (offsetY > (self.articleView.listTableView.contentSize.height - self.articleView.listTableView.frame.size.height)) {
            // 当子ScrollView的contenOffset大于tableView的可移动距离时
            offsetY = self.articleView.listTableView.contentOffset.y - rubberBandDistance(detal, CGRectGetHeight(self.bounds));
        }
        NSLog(@"subTableView %f",offsetY);
        self.articleView.listTableView.contentOffset = CGPointMake(0, offsetY);
    } else {
        CGFloat mainOffsetY = self.mainScrollView.contentOffset.y - detal;
        if (mainOffsetY < 0) {
            // 滚动到顶部之后继续往上滚动需要乘以一个小于1的系数
            mainOffsetY = self.mainScrollView.contentOffset.y - rubberBandDistance(detal, CGRectGetHeight(self.bounds));
            CGFloat subScrollViewOffsetY = self.articleView.listTableView.contentOffset.y - detal;
            if (subScrollViewOffsetY < 0) {
                // 触发子Scrollview下拉刷新
                mainOffsetY = 0;
                subScrollViewOffsetY = self.articleView.listTableView.contentOffset.y - rubberBandDistance(detal, CGRectGetHeight(self.bounds));
                self.articleView.listTableView.contentOffset = CGPointMake(0, subScrollViewOffsetY);
                if (subScrollViewOffsetY <= -30) {
                    [self.articleView manualTriggerArticleRefresh];
                }
            }
            NSLog(@"sub %f",subScrollViewOffsetY);
        } else if (mainOffsetY > self.loopView.loopH) {
            mainOffsetY = self.loopView.loopH;
        }
        NSLog(@"MainScrollView %f",mainOffsetY);
        self.mainScrollView.contentOffset = CGPointMake(0, mainOffsetY);
    }
    
    BOOL outsideFrame = [self outsideFrame];
    if (outsideFrame && (self.decelerationBehavior && !self.springBehavior)) {
        CGPoint target = CGPointZero;
        BOOL isMain = NO;
        if (self.mainScrollView.contentOffset.y < 0) {
            self.dynamicItem.center = self.mainScrollView.contentOffset;
            target = CGPointZero;
            isMain = YES;
        } else if (self.articleView.listTableView.contentOffset.y > (self.articleView.listTableView.contentSize.height - self.articleView.listTableView.frame.size.height)) {
            self.dynamicItem.center = self.articleView.listTableView.contentOffset;
            target.x = self.articleView.listTableView.contentOffset.x;
            target.y = self.articleView.listTableView.contentSize.height > self.articleView.listTableView.frame.size.height ? self.articleView.listTableView.contentSize.height - self.articleView.listTableView.frame.size.height : 0;
            isMain = NO;
        } else if (self.articleView.listTableView.contentOffset.y < 0) {
            self.dynamicItem.center = self.articleView.listTableView.contentOffset;
            target = CGPointZero;
            isMain = NO;
        }
        [self.animator removeBehavior:self.decelerationBehavior];
        WeakSelf;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.dynamicItem attachedToAnchor:target];
        springBehavior.length = 0;
        springBehavior.damping = 1;
        springBehavior.frequency = 2;
        springBehavior.action = ^{
            if (isMain) {
                weakSelf.mainScrollView.contentOffset = weakSelf.dynamicItem.center;
                if (weakSelf.mainScrollView.contentOffset.y == 0) {
                    weakSelf.articleView.listTableView.contentOffset = CGPointZero;
                }
            } else {
                weakSelf.articleView.listTableView.contentOffset = weakSelf.dynamicItem.center;
                if (weakSelf.articleView.listTableView.mj_footer.refreshing) {
                    weakSelf.articleView.listTableView.contentOffset = CGPointMake(weakSelf.articleView.listTableView.contentOffset.x, weakSelf.articleView.listTableView.contentOffset.y + 44);
                } else if (weakSelf.articleView.listTableView.mj_header.refreshing) {
                    weakSelf.articleView.listTableView.contentOffset = CGPointMake(weakSelf.articleView.listTableView.contentOffset.x, weakSelf.articleView.listTableView.contentOffset.y + 44);
                }
            }
        };
        [self.animator addBehavior:springBehavior];
        self.springBehavior = springBehavior;
    }
     */
}

// 判断是否超出ViewFrame的边界
- (BOOL)outsideFrame {
    /*
    if (self.mainScrollView.contentOffset.y < 0) {
        return YES;
    }
    if (self.articleView.listTableView.contentOffset.y < 0) {
        return YES;
    }
    if (self.articleView.listTableView.contentSize.height > self.articleView.listTableView.frame.size.height) {
        if (self.articleView.listTableView.contentOffset.y > (self.articleView.listTableView.contentSize.height - self.articleView.listTableView.frame.size.height)) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if (self.articleView.listTableView.contentOffset.y > 0) {
            return YES;
        } else {
            return NO;
        }
    }
     */
    return NO;
}

#pragma mark - lazy
- (AWDynamicLoopView *)loopView {
    if (!_loopView) {
        _loopView = [[AWDynamicLoopView alloc] init];
    }
    return _loopView;
}

@end
