//
//  AWHeadPortraitView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadPortraitView.h"
#import "AWHeadPortraitTableViewCell.h"

static NSString *HeadPortraitCell = @"HeadPortraitCell";

@interface AWHeadPortraitView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *headTableView;

/** dataSource */
@property (nonatomic,strong) NSArray <AWHeadPortraitModel *>*dataSource;

@end

@implementation AWHeadPortraitView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTableView];
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

- (void)loadHeadPortraitTableViewSource:(NSArray<AWHeadPortraitModel *> *)headSource {
    self.dataSource = headSource;
    [self.headTableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat H = (ScreenWidth - 24)/2/74*75 + 40;
    return H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AWHeadPortraitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeadPortraitCell];
    [cell loadHeadPortraitCellModel:self.dataSource[indexPath.row].imageList typeName:self.dataSource[indexPath.row].groupName];
    return cell;
}

#pragma mark - private methods
- (void)setupTableView {
    self.headTableView.delegate = self;
    self.headTableView.dataSource = self;
    [self.headTableView registerNib:[UINib nibWithNibName:@"AWHeadPortraitTableViewCell" bundle:nil] forCellReuseIdentifier:HeadPortraitCell];
}

@end
