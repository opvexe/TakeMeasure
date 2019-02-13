//
//  ATTabBarControllerConfig.m
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/19.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ATTabBarControllerConfig.h"
#import "ATBaseNavigationViewController.h"
#import "ATRootViewController.h"
#import "ATHomeViewController.h"
#import "ATMineViewController.h"

@interface ATTabBarControllerConfig ()
@property (nonatomic, strong) CYLTabBarController *tabBarController;
@end

@implementation ATTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;
        UIOffset titlePositionAdjustment = UIOffsetZero;
        ATRootViewController *tabBarController = [ATRootViewController tabBarControllerWithViewControllers:self.viewControllers
                                                                                     tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                               imageInsets:imageInsets
                                                                                   titlePositionAdjustment:titlePositionAdjustment];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    ATHomeViewController *homeViewController = [[ATHomeViewController alloc] init];
    UIViewController *homeNavigationController = [[ATBaseNavigationViewController alloc]
                                                  initWithRootViewController:homeViewController];
    
    ATMineViewController *mineViewController =[[ATMineViewController alloc]init];
    UIViewController *mineNavigationController = [[ATBaseNavigationViewController alloc]initWithRootViewController:mineViewController];
    
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 mineNavigationController,
                                 ];
    return viewControllers;
}


- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *homeTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"首页",
                                                CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0.0f,AT_iPhoneX ?0.0f:(-AT_TabbarHeight/2 + 10.0f))]
                                                };

    NSDictionary *mineTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"我",
                                                CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(0.0f,AT_iPhoneX ?0.0f:(-AT_TabbarHeight/2 + 10.0f))]
                                                };
    
    NSArray *tabBarItemsAttributes = @[
                                       homeTabBarItemsAttributes,
                                       mineTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    ///普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor TextGrayColor];
    normalAttrs[NSFontAttributeName] = [UIFont SYPingFangSCLightFontOfSize:Number(16.0f)];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    selectedAttrs[NSFontAttributeName] = [UIFont SYPingFangSCLightFontOfSize:Number(14.0f)];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 设置背景图片
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
}

@end
