//
//  TPBaseNavigationVC.m
//  TPFoundation_Example
//
//  Created by Topredator on 2021/11/1.
//  Copyright © 2021 周晓路. All rights reserved.
//

#import "TPBaseNavigationVC.h"

@interface TPBaseNavigationVC ()

@end

@implementation TPBaseNavigationVC
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        rootViewController.hidesBottomBarWhenPushed = NO;
        self.navigationBar.translucent = NO;
    }
    return self;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {
        if (self.viewControllers.count == 1) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
@end
