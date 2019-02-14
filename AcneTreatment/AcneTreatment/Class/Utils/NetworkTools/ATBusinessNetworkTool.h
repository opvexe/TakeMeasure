//
//  ATBusinessNetworkTool.h
//  AcneTreatment
//
//  Created by FaceBook on 2019/2/14.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDNetworkHelper.h"
NS_ASSUME_NONNULL_BEGIN

@interface ATBusinessNetworkTool : NSObject

+(void)GetWithHomeCompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
