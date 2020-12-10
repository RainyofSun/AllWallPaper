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

static NSString *DynamicSectionHeader = @"DynamicSectionHeader";
static NSString *DynamicFenLeiCell    = @"DynamicFenLeiCell";

@interface AWDynamicMainView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dynamicTableView;
/** loopView */
@property (nonatomic,strong) AWDynamicLoopView *loopView;
/** fenLeiSource */
@property (nonatomic,strong) NSArray <AWFenLeiModel *>*fenLeiSource;

@end

@implementation AWDynamicMainView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTableView];
}

- (void)dealloc {
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

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 60 : 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AWDynamicFenLeiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicFenLeiCell];
        [cell loadFenLeiTableViewCellSource:self.fenLeiSource];
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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

#pragma mark - private methods
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
}

#pragma mark - lazy
- (AWDynamicLoopView *)loopView {
    if (!_loopView) {
        _loopView = [[AWDynamicLoopView alloc] init];
    }
    return _loopView;
}

@end
