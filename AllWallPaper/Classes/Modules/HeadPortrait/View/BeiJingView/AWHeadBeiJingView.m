//
//  AWHeadBeiJingView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadBeiJingView.h"
#import "AWHeadBeiJingTableViewCell.h"

static NSString *HeadBeiJingCell = @"HeadBeiJingCell";

@interface AWHeadBeiJingView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *beiJingTableView;

/** dataSource */
@property (nonatomic,strong) NSArray <AWHeadPortraitModel *>*dataSource;

@end

@implementation AWHeadBeiJingView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTableView];
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

- (void)loadHeadPortraitBeiJingTableViewSource:(NSArray<AWHeadPortraitModel *> *)headSource {
    self.dataSource = headSource;
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
    [cell loadHeadBeiJingCellSource:self.dataSource[indexPath.row].imageList];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - private methods
- (void)setupTableView {
    self.beiJingTableView.delegate = self;
    self.beiJingTableView.dataSource = self;
    [self.beiJingTableView registerNib:[UINib nibWithNibName:@"AWHeadBeiJingTableViewCell" bundle:nil] forCellReuseIdentifier:HeadBeiJingCell];
}

@end
