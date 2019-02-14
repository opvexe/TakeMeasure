//
//  ATHomeContentModel.h
//  AcneTreatment
//
//  Created by FaceBook on 2019/2/14.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ATBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATHomeContentModel : ATBaseModel

///MARK: 标题
@property(nonatomic,copy)NSString *title;

///MARK:来源
@property(nonatomic,copy)NSString *source;

///MARK:图片
@property(nonatomic,copy)NSString *middle_image;

///MARK:评论人数
@property(nonatomic,copy)NSString *comments_count;

///MARK: 跳转id
@property(nonatomic,copy)NSString *group_id;

@end

NS_ASSUME_NONNULL_END
