//
//  ATBaseNavigationViewController.m
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/18.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ATBaseNavigationViewController.h"

@interface ATBaseNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation ATBaseNavigationViewController

+ (void)load{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor TextGrayColor],NSForegroundColorAttributeName,[UIFont SYPingFangSCLightFontOfSize:Number(14.0f)],NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [navigationBarAppearance setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setShadowImage:[UIImage new]];
    if (@available(iOS 11.0, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-2.0, -0.4) forBarMetrics:UIBarMetricsDefault];
    } else {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -2) forBarMetrics:UIBarMetricsDefault];
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
         backgroundImage = [UIImage imageWithColor:[UIColor BgColor]];
        
        textAttributes = @{
                           NSFontAttributeName :[UIFont SYPingFangSCLightFontOfSize:Number(14.0f)],
                           NSForegroundColorAttributeName :[UIColor TextGrayColor],
                           };
        
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageWithColor:[UIColor BgColor]];
        textAttributes = @{
                           UITextAttributeFont : [UIFont SYPingFangSCLightFontOfSize:Number(14.0f)]),
                           UITextAttributeTextColor :[UIColor TextGrayColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        [viewController addPopBackBarButtonItem];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
