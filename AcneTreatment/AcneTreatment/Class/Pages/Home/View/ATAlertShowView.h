//
//  ATAlertShowView.h
//  AcneTreatment
//
//  Created by FaceBooks on 2018/8/19.
//  Copyright © 2018年 FaceBook. All rights reserved.
//

#import "ATBaseView.h"
@interface ATAlertShowView : ATBaseView

+ (ATAlertShowView *)showWithCompelet:(void(^)(NSString *comments))completeBlock;

-(void)dismiss;

@end
