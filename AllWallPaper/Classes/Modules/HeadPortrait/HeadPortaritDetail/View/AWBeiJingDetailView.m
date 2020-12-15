//
//  AWBeiJingDetailView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBeiJingDetailView.h"
#import "AWHeadBeiJingTableViewCell.h"

static NSString *HeadBeiJingCell = @"HeadBeiJingCell";

@interface AWBeiJingDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *beiJingTableView;
/** dataSource */
@property (nonatomic,strong) NSArray <AWStaticCellModel *>*dataSource;

@end

@implementation AWBeiJingDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTableView];
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadBeiJingDetailSource:(NSArray<AWStaticCellModel *> *)paperSource {
    self.dataSource = paperSource;
    [self.beiJingTableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AWHeadBeiJingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeadBeiJingCell];
    [cell loadHeadBeiJingCellSource:self.dataSource[indexPath.row].imageUrlSmall tynaName:@""];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.beiJingDelegate != nil && [self.beiJingDelegate respondsToSelector:@selector(didSelectedBeiJingPaper:)]) {
        [self.beiJingDelegate didSelectedBeiJingPaper:self.dataSource[indexPath.row].imageUrl];
    }
}

#pragma mark - private methods
- (void)setupTableView {
    self.beiJingTableView.delegate = self;
    self.beiJingTableView.dataSource = self;
    [self.beiJingTableView registerNib:[UINib nibWithNibName:@"AWHeadBeiJingTableViewCell" bundle:nil] forCellReuseIdentifier:HeadBeiJingCell];
}

@end
