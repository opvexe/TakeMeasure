//
//  ATMenuView.h
//  AcneTreatment
//
//  Created by FaceBook on 2019/2/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATMenuView : UIView
///MARK: 圆角 默认10.0f
@property (nonatomic,assign) CGFloat cornerRaius;

- (instancetype)initWithFrame:(CGRect)frame relyonView:(id)view;

-(void)show;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
