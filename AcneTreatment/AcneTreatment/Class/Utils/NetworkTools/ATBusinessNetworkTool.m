//
//  ATBusinessNetworkTool.m
//  AcneTreatment
//
//  Created by FaceBook on 2019/2/14.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ATBusinessNetworkTool.h"

typedef NS_ENUM(NSUInteger, NetworkToolMethodType) {
    NetworkToolMethodTypeGET,
    NetworkToolMethodTypePOST,
};

@implementation ATBusinessNetworkTool

+(NSDictionary *)pargram:(NSDictionary *)parameters {
    NSMutableDictionary *pargram = [NSMutableDictionary dictionaryWithCapacity:0];
    if (parameters) {
        [pargram addEntriesFromDictionary:parameters];
    }

    return  pargram;
}

+(NSURLSessionDataTask *)WithMethodType:(NetworkToolMethodType) type URL:(NSString *)URL parameters:(NSDictionary *)parameters   success:(CPNetworkRequestSuccess)success
                                failure:(CPNetworkRequestFailed)failure {
    
//    NSMutableDictionary  *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
//
//    NSDictionary *pargram = [self pargram:newParameters];
    
    URL = [NSString stringWithFormat:@"%@%@",HOST_API,URL];
    
    switch (type) {
        case NetworkToolMethodTypePOST:{
            
            return [WDNetworkHelper POST:URL parameters:parameters success:^(id responseObject) {
                
                
            } failure:^(NSError *error) {
            
                
            }];
        }
            break;
            
        default:{
         
            return [WDNetworkHelper GET:URL parameters:nil success:^(id responseObject) {
                
                NSLog(@"%@",responseObject);
            } failure:^(NSError *error) {
                
                
            }];
            
        }
            break;
    }
}






+(void)GetWithHomeCompleteSuccessfull:(void (^)(id responseObject))successfull  failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:0];
    [self WithMethodType:NetworkToolMethodTypeGET URL:kHomeDefalut parameters:parameters success:successfull failure:failure];
}

@end
