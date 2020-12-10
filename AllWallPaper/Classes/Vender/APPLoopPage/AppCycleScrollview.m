//
//  AppCycleScrollview.m
//  LibTools
//
//  Created by 刘冉 on 2018/10/17.
//  Copyright © 2018年 LRCY. All rights reserved.
//

#import "AppCycleScrollview.h"
#import "AppCycleScrollviewFlowLayout.h"
#import "AppCycleCollectionViewCell.h"
#import "AppPageControl.h"

@interface AppCycleScrollview ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) AppCycleScrollviewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *imgArr;//图片数组
@property (nonatomic,assign) NSInteger totalItems;//item总数
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSUInteger currentpage;//当前页
//分页控制器
@property (nonatomic,strong) AppPageControl *pageControl;

@end

static NSString *const cellID = @"cellID";

@implementation AppCycleScrollview
{
    float _oldPoint;
    NSInteger _dragDirection;
}

+ (instancetype)appCycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop cycleDelegate:(nonnull id<AppCycleScrollviewDelegate>)delegate{
    AppCycleScrollview *cycleScrollView = [[AppCycleScrollview alloc]initWithFrame:frame];
    cycleScrollView.infiniteLoop = infiniteLoop;
    cycleScrollView.delegate = delegate;
    return cycleScrollView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initialization];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        
    }
    return self;
}
-(void)initialization
{
    //初始化
    _infiniteLoop = YES;
    _autoScroll = YES;
    _isZoom = NO;
    _itemWidth = self.bounds.size.width;
    _itemSpace = 0;
    _imgCornerRadius = 0;
    _autoScrollTimeInterval = 2;
    _pageControl.currentPage = 0;
    _heightProportion = 0.8;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)setImageURLStringsGroup:(NSArray<NSString *> *)imageURLStringsGroup {
    _imageURLStringsGroup = imageURLStringsGroup;
    self.imgArr = [imageURLStringsGroup mutableCopy];

}

-(CGFloat )defaultSpace
{
    return ([UIScreen mainScreen].bounds.size.width - self.itemWidth)/2;
}

- (void)setPageControlStyle {
    _pageControl.currentColor = [UIColor whiteColor];
    _pageControl.otherColor = [UIColor colorWithWhite:1 alpha:0.6];
    //设置非选中点的宽度是高度的倍数(设置长条形状)
    _pageControl.otherMultiple = 1;
    //设置选中点的宽度是高度的倍数(设置长条形状)
    _pageControl.currentMultiple = 1;
    _pageControl.controlSpacing = 5;
    _pageControl.controlSize = 6;
    _pageControl.horizontalType = PageControlHorizontalRight;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * self.heightProportion);
    self.pageControl.frame = CGRectMake(0, self.bounds.size.height * 0.85, self.bounds.size.width, self.bounds.size.height * 0.15);
    [self setPageControlStyle];
    self.flowLayout.itemSize = CGSizeMake(_itemWidth, self.collectionView.bounds.size.height);
    self.flowLayout.minimumLineSpacing = self.itemSpace;
    if (_imgArr.count == 1 || _imgArr.count == 2) {
        CGFloat insetW = 0.0621 * self.bounds.size.width;
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, insetW, 0, 0);
    }
    if(self.collectionView.contentOffset.x == 0 && _totalItems > 0)
    {
        NSInteger targeIndex = 0;
        if(self.infiniteLoop)
        {//无线循环
            // 如果是无限循环，应该默认把 collection 的 item 滑动到 中间位置。
            // 注意：此处 totalItems 的数值，其实是图片数组数量的 100 倍。
            // 乘以 0.5 ，正好是取得中间位置的 item 。图片也恰好是图片数组里面的第 0 个。
            targeIndex = _totalItems * 0.5;
        }else
        {
            targeIndex = 0;
        }
        //设置图片默认位置
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targeIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        _oldPoint = self.collectionView.contentOffset.x;
        self.collectionView.userInteractionEnabled = YES;
        
    }
}
#pragma mark  - event

#pragma mark  - delegate
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.collectionView.userInteractionEnabled = NO;
    if (!self.imgArr.count) return; // 解决清除timer时偶尔会出现的问题
    self.pageControl.currentPage = [self currentIndex] % self.imgArr.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _oldPoint = scrollView.contentOffset.x;
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.collectionView.userInteractionEnabled = YES;
    if (!self.imgArr.count) return; // 解决清除timer时偶尔会出现的问题
}

//手离开屏幕的时候
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    //如果是向右滑或者滑动距离大于item的一半，则像右移动一个item+space的距离，反之向左
    float currentPoint = scrollView.contentOffset.x;
    float moveWidth = currentPoint-_oldPoint;
    int shouldPage = moveWidth/(self.itemWidth/2);
    if (velocity.x>0 || shouldPage > 0) {
        _dragDirection = 1;
    }else if (velocity.x<0 || shouldPage < 0){
        _dragDirection = -1;
    }else{
        _dragDirection = 0;
    }
    self.collectionView.userInteractionEnabled = NO;
    //
    NSInteger currentIndex = (_oldPoint + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    NSIndexPath *scrollPath = [NSIndexPath indexPathForRow:currentIndex + _dragDirection inSection:0];
    if (scrollPath.row > _totalItems || !self.imgArr.count || scrollPath == nil) {
        return;
    }
    if (scrollPath.row == _totalItems) {
        [self scrollToIndex:_totalItems];
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:scrollPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

- (void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    //松开手指滑动开始减速的时候，设置滑动动画
    NSInteger currentIndex = (_oldPoint + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    NSIndexPath *scrollPath = [NSIndexPath indexPathForRow:currentIndex + _dragDirection inSection:0];
    if (scrollPath.row > _totalItems || !self.imgArr.count || scrollPath == nil) {
        return;
    }
    if (scrollPath.row == _totalItems) {
        [self scrollToIndex:_totalItems];
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:scrollPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (float)nextPointCurrentPoint:(int)shouldPage{
    return (shouldPage+1)/2*self.itemWidth+self.itemSpace;
}
- (float)lastPointCurrentPoint:(int)shouldPage{
    shouldPage = -shouldPage;
    return -(shouldPage+1)/2*self.itemWidth-self.itemSpace;
}
#pragma mark  - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalItems;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    AppCycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    long itemIndex = (int) indexPath.item % self.imgArr.count;
    cell.imgCornerRadius = self.imgCornerRadius;
    cell.cellPlaceholderImage = self.cellPlaceholderImage;
    if ([self.imgArr[itemIndex] hasPrefix:@"http"]) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:self.imgArr[itemIndex]] placeholder:self.placeholderImage];
    } else {
        cell.imageView.image = [UIImage imageNamed:self.imgArr[itemIndex]];
    }
    return cell;
}
#pragma mark  - 代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:[self currentIndex] % self.imgArr.count];
    }
}
#pragma mark  - notification

#pragma mark  - private
- (void)setupTimer
{
    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = timer;
    
}
- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}
-(void)automaticScroll
{
    if(_totalItems == 0) return;
    
    NSInteger currentIndex = [self currentIndex];
    
    NSInteger targetIndex = currentIndex + 1;
    
    [self scrollToIndex:targetIndex];
}
-(NSInteger)currentIndex
{
    if(self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0)
        return 0;
    NSInteger index = 0;
    
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {//水平滑动
        index = (self.collectionView.contentOffset.x + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    }else{
        index = (self.collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5)/ _flowLayout.itemSize.height;
    }
    return MAX(0,index);
    
}
-(void)scrollToIndex:(NSInteger)index
{
    if(index >= _totalItems) //滑到最后则调到中间
    {
        if(self.infiniteLoop)
        {
            index = _totalItems * 0.5;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    
}
#pragma mark  - public

#pragma mark  - setter or getter
- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!_backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.frame = CGRectMake(self.itemSpace, 0, self.bounds.size.width - self.itemSpace * 2, self.collectionView.bounds.size.height);
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        bgImageView.layer.cornerRadius = self.imgCornerRadius;
        bgImageView.clipsToBounds = YES;
        [self addSubview:bgImageView];
        [self insertSubview:bgImageView belowSubview:self.collectionView];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
    
}
-(void)setItemWidth:(CGFloat)itemWidth
{
    _itemWidth = itemWidth;
    self.flowLayout.itemSize = CGSizeMake(itemWidth, self.collectionView.bounds.size.height);
}
-(void)setItemSpace:(CGFloat)itemSpace
{
    _itemSpace = itemSpace;
    self.flowLayout.minimumLineSpacing = itemSpace;
}
-(void)setIsZoom:(BOOL)isZoom
{
    _isZoom = isZoom;
    self.flowLayout.isZoom = isZoom;
}

- (void)setIsHidePageControl:(BOOL)isHidePageControl {
    _isHidePageControl = isHidePageControl;
    self.pageControl.hidden = isHidePageControl;
}
-(void)setImgArr:(NSArray *)imgArr
{
    _imgArr = imgArr;
    self.pageControl.numberOfPages = imgArr.count;
    //如果循环则100倍，
    _totalItems = self.infiniteLoop?imgArr.count * 100:imgArr.count;
    if(_imgArr.count > 1)
    {
        self.collectionView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    }else
    {
        //不循环
        self.collectionView.scrollEnabled = NO;
        [self invalidateTimer];
    }
    
    [self.collectionView reloadData];
    
}
-(void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    //创建之前，停止定时器
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self setupTimer];
    }
}
-(UICollectionView *)collectionView
{
    if(_collectionView == nil)
    {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        //注册cell
        [_collectionView registerClass:[AppCycleCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
    }
    return _collectionView;
}
-(AppPageControl *)pageControl
{
    if(_pageControl == nil)
    {
        _pageControl = [[AppPageControl alloc]init];
    }
    return _pageControl;
}
-(AppCycleScrollviewFlowLayout *)flowLayout
{
    if(_flowLayout == nil)
    {
        _flowLayout = [[AppCycleScrollviewFlowLayout alloc]init];
        _flowLayout.isZoom = self.isZoom;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
    }
    return _flowLayout;
}

@end
