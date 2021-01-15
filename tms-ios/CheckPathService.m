//
//  CheckPathService.m
//  YBDriver
//
//  Created by  on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#import "CheckPathService.h"
#import "AppDelegate.h"
#import <AFNetworking.h>
#import "LocationModel.h"
#import "Tools.h"
#import "AESConvertHelper.h"

@interface CheckPathService () {
    
}

@end

@implementation CheckPathService

- (instancetype)init {
    if(self = [super init]) {
        _orderLocations = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 * 获取订单线路位置点集合
 *
 * orderIdx: 订单的 idx
 *
 * httpresponseProtocol: 网络请求协议
 */
- (void)getOrderLocaltions:(NSString *)idx {
    
    __weak __typeof(self)weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kApi, @"kc-transport/tmsApp/getPathData"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    NSString *params = [NSString stringWithFormat:@"{\"shipmentId\":\"%@\"}", idx];
    
    NSString * aesParamString = [AESConvertHelper convertToAesWithParam:params];
    
    NSDictionary *parameters = @{@"param" : aesParamString};
    
    NSLog(@"获取配载单轨迹参数加密前：%@", params);
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * response = [AESConvertHelper convertAesToParam:responseObject[@"result"]];
        
        NSLog(@"请求成功---%@", response);
        int States = [response[@"States"] intValue];
        NSLog(@"----------%d", States);
        if(States == 1) {
            NSArray *arrResult = response[@"pathData"];
            for (int i = 0; i < arrResult.count; i++) {
                LocationModel *location = [[LocationModel alloc] init];
                [location setDict:arrResult[i]];
                location.CORDINATEY = [arrResult[i][@"lat"] doubleValue];
                location.CORDINATEX = [arrResult[i][@"lon"] doubleValue];
                [weakSelf.orderLocations addObject:location];
                NSLog(@"%@", location);
            }
            if([_delegate respondsToSelector:@selector(success)]) {
                [_delegate success];
            }
        }else {
            NSString *msg = response[@"Msg"];
            if([_delegate respondsToSelector:@selector(failure:)]) {
                [_delegate failure:msg];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---%@", error);
        if([_delegate respondsToSelector:@selector(failure:)]) {
            [_delegate failure:nil];
        }
    }];
}

@end
