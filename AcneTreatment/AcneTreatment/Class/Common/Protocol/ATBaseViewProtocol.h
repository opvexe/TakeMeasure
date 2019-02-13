//
//  ATBaseViewProtocol.h
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/19.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATBaseModel;
@protocol ATBaseViewProtocol <NSObject>
@optional

- (void)ATSinitConfingViews;

-(void)ATConfigSignalDataSoucre;

-(void)InitDataWithModel:(ATBaseModel *)model;

@end
