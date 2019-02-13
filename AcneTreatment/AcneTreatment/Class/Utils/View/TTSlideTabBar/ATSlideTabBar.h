//
//  ATSlideTabBar.h
//  AcneTreatment
//
//  Created by FaceBook on 2019/2/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ATSlideTabBarDelegate
@required
- (void)onTabTapAction:(NSInteger)index;

@end
@interface ATSlideTabBar : UIView

@property (nonatomic, weak) id <ATSlideTabBarDelegate> delegate;

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex;

@end

NS_ASSUME_NONNULL_END
