//
//  AWDynamicViewModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicViewModel.h"
#import "AWDynamicMainView.h"
#import "AWLoopModel.h"
#import "AWFenLeiModel.h"

@interface AWDynamicViewModel ()

/** mainView */
@property (nonatomic,strong) AWDynamicMainView *mainView;

@end

@implementation AWDynamicViewModel

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadMainDynamicView:(UIView *)view {
    [view addSubview:self.mainView];
    [self.mainView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self getLocalData];
}

#pragma mark - private methods
- (void)getLocalData {
    dispatch_group_t netGroup = dispatch_group_create();
    WeakSelf;
    dispatch_group_enter(netGroup);
    __block NSArray <AWLoopModel *>*tempSource = nil;
    [MPLocalData MPGetLocalDataFileName:@"loop0" localData:^(id  _Nonnull responseObject) {
        tempSource = [AWLoopModel modelArrayWithDictArray:(NSArray *)responseObject];
        dispatch_group_leave(netGroup);
    } errorBlock:^(NSString * _Nullable errorInfo) {
        dispatch_group_leave(netGroup);
    }];
    
    dispatch_group_enter(netGroup);
    __block NSArray <AWFenLeiModel *>* fenLeiSource = nil;
    [MPLocalData MPGetLocalDataFileName:@"FenLei0" localData:^(id  _Nonnull responseObject) {
        NSDictionary *tempDict = (NSDictionary *)responseObject;
        fenLeiSource = [AWFenLeiModel modelArrayWithDictArray:(NSArray *)[tempDict objectForKey:@"list"]];
        dispatch_group_leave(netGroup);
    } errorBlock:^(NSString * _Nullable errorInfo) {
        dispatch_group_leave(netGroup);
    }];
    
    dispatch_group_notify(netGroup, dispatch_get_main_queue(), ^{
        [weakSelf.mainView reloadLoopSource:tempSource];
        [weakSelf.mainView reloadFenleiSource:fenLeiSource];
    });
}

#pragma mark - lazy
- (AWDynamicMainView *)mainView {
    if (!_mainView) {
        _mainView = [[[NSBundle mainBundle] loadNibNamed:@"AWDynamicMainView" owner:nil options:nil] firstObject];
    }
    return _mainView;
}

@end
