//
//  AWDynamicFenLeiTableViewCell.m
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicFenLeiTableViewCell.h"

@interface AWDynamicFenLeiTableViewCell ()<UIScrollViewDelegate>

/** scrollView */
@property (nonatomic,strong) UIScrollView *scrollView;
/** hasBuilded */
@property (nonatomic,assign) BOOL hasBuiled;

@end

@implementation AWDynamicFenLeiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.hasBuiled = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupScrollView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.scrollView autoCenterInSuperview];
    [self.scrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
    [self.scrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
    [self.scrollView autoSetDimension:ALDimensionWidth toSize:ScreenWidth - 20];
}

#pragma mark - public methods
- (void)loadFenLeiTableViewCellSource:(NSArray<AWFenLeiModel *> *)cellSource {
    if (!cellSource.count || self.hasBuiled) {
        return;
    }
    [self setupItems:cellSource];
}

#pragma mark - Target
- (void)selectedFenLei:(UIButton *)sender {
    [[self nearsetViewController].navigationController pushViewController:[FLModuleMsgSend sendMsg:@{@"title":sender.currentTitle,@"index":[NSNumber numberWithInteger:(sender.tag - 100)]} vcName:@"AWFenLeiDetailViewController"] animated:YES];
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
    CGFloat x = scrollView.contentOffset.x / ScreenWidth;
    FLOG(@"人为拖拽scrollView导致滚动完毕 %f",x);
}

#pragma mark - private methods
- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
}

- (void)setupItems:(NSArray <AWFenLeiModel *>*)source {
    CGFloat itemW = 120;
    CGFloat itemH = itemW/2;
    CGFloat Padding = 10.f;
    self.scrollView.contentSize = CGSizeMake((itemW + Padding) * source.count - Padding, 0);
    for (NSInteger i = 0; i < source.count; i ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:source[i].name forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [item loadBackgroudNetworkImg:source[i].image bigPlaceHolder:NO];
        item.layer.cornerRadius = 5.f;
        item.clipsToBounds = YES;
        item.adjustsImageWhenHighlighted = NO;
        item.frame = CGRectMake((itemW + Padding) * i, 0, itemW, itemH);
        item.tag = 100 + i;
        [item addTarget:self action:@selector(selectedFenLei:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:item];
    }
    self.hasBuiled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
