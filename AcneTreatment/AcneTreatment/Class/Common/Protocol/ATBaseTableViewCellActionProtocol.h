//
//  ATBaseTableViewCellActionProtocol.h
//  AcneTreatment
//
//  Created by FaceBook on 2018/8/20.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

///MARK: 事件类型
typedef NS_ENUM(NSUInteger, ClickType) {
    ClickTypeDislike,
    ClickTypeComment,
    ClickTypeFavorite,
};

@class ATBaseModel;
@class ATBaseTableViewCell;
@protocol ATBaseTableViewCellActionProtocol <NSObject>

@optional
-(void)ClickTableViewCell:(ATBaseTableViewCell *)cell AtItems:(NSInteger)items model:(ATBaseModel *)model;
-(void)tapTableviewCell:(ATBaseTableViewCell *)cell sliderType:(DisplayType)playType tapType:(ClickType)tapType model:(ATBaseModel *)model relyonView:(id)view;

@end
