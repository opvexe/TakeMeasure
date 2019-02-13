//
//  UIColor+Theme.h
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/18.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Theme)

/**
 * 随机色
 */
+(UIColor *)Theme_ColorRandom;

/**
 *  主色调
 */
+(UIColor *)MainColor;
/**
 *  整体背景颜色
 */
+(UIColor *)BgColor;
/**
 * 辅助线颜色
 */
+(UIColor *)BgLineColor;
/**
 *  主文字颜色
 */
+(UIColor *)TextColor;
/**
 *  文字辅助灰色颜色
 */
+(UIColor *)TextGrayColor;
/**
 *  文字副标题颜色
 */
+(UIColor *)TextSubTitleColor;
/**
 *  TableView整体背景颜色
 */
+(UIColor *)BgTableViewColor;

@end
