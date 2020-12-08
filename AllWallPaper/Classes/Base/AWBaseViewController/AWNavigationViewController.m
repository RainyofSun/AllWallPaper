//
//  AWNavigationViewController.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWNavigationViewController.h"

@interface AWNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)NSHashTable<UIViewController*>*exceptViewcontrollers ;
@property(nonatomic,assign)UIInterfaceOrientationMask orientationMask;
@property(nonatomic,assign)UIInterfaceOrientation preferredInterfaceOrientation;
@property(nonatomic,assign)NSInteger preCount;

@end

@implementation AWNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.delegate = self;
        self.interactivePopGestureRecognizer.delegate = self;
        _orientationMask = UIInterfaceOrientationMaskPortrait;
        _preferredInterfaceOrientation =UIInterfaceOrientationPortrait;
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        //            [self.navigationBar setBackgroundImage:[UIImage imageWithColor:HexColor(0xfcdd73) size:CGSizeMake(WINDOW_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.barTintColor = RGB(255, 255, 255);
        self.navigationBar.translucent = NO;
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
                                                      forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage imageWithColor:RGB(237,239,245)]];
    }
    return self;
}

- (NSHashTable<UIViewController *> *)exceptViewcontrollers {
    if (_exceptViewcontrollers==nil) {
        _exceptViewcontrollers = [NSHashTable hashTableWithOptions:(NSPointerFunctionsWeakMemory)];
    }
    return _exceptViewcontrollers;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return [self cheackRecogerViewcontroll];
}

- (BOOL)cheackRecogerViewcontroll {
    //枚举
    NSEnumerator *enumerator;
    enumerator =[_exceptViewcontrollers objectEnumerator];
    UIViewController*temViewcontroller ;
    while (temViewcontroller = [enumerator nextObject])
    {
        if ([temViewcontroller isEqual:self.topViewController]) {
            return NO;
        }
    }
    return YES;
}

- (void)addLEdExceptViewController:(UIViewController *)exceptviewController {
    [_exceptViewcontrollers addObject:exceptviewController];
}

- (void)setOrientationMask:(UIInterfaceOrientationMask)orientationMask preferredInterfaceOrientation:(UIInterfaceOrientation)preferredInterfaceOrientation {
    _orientationMask = orientationMask;
    _preferredInterfaceOrientation = preferredInterfaceOrientation;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [super popToRootViewControllerAnimated:animated];
}

- (BOOL)shouldAutorotate {
    return YES;
}

// 设备支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _orientationMask;
}

// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return _preferredInterfaceOrientation;
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
