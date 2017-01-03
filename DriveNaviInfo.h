//
//  DriveNaviInfo.h
//  gaodeTEST
//
//  Created by cwwmac01 on 2016/12/5.
//  Copyright © 2016年 朗泰恒盛. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>
@interface DriveNaviInfo : NSObject 

@property (nonatomic,copy)void(^result)(AMapNaviRoute* result);

//此工具类是为了计算两个坐标点之间的驾车的距离和时间 使用的方法是
//    _info = [[DriveNaviInfo alloc] init];
//    [_info calculateDriveRountWithStartPoint:CLLocationCoordinate2DMake(39.908791,  116.321257) endPoint:CLLocationCoordinate2DMake(39.993135,  116.474175)];
//    [_info getCalculateRountDriveInfo:^(AMapNaviRoute *result) {
//
//    }];
//在回调中得到result的routeLength 即为驾车距离 routeTime 为驾车时间

-(void)calculateDriveRountWithStartPoint:(CLLocationCoordinate2D)startPoint endPoint:(CLLocationCoordinate2D)endPoint;

- (void)getCalculateRountDriveInfo:(void(^)(AMapNaviRoute * result))callBack;
@end
