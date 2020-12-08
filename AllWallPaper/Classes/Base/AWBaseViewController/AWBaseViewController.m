//
//  AWBaseViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseViewController.h"

@interface AWBaseViewController ()

@end

@implementation AWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBackButtonDefault];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
