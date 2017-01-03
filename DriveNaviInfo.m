//
//  DriveNaviInfo.m
//  gaodeTEST
//
//  Created by cwwmac01 on 2016/12/5.
//  Copyright © 2016年 朗泰恒盛. All rights reserved.
//

#import "DriveNaviInfo.h"
@interface DriveNaviInfo()<AMapNaviDriveManagerDelegate>
@property (nonatomic,strong)AMapNaviDriveManager * driverManager;
@end
@implementation DriveNaviInfo

-(void)calculateDriveRountWithStartPoint:(CLLocationCoordinate2D)startPoint endPoint:(CLLocationCoordinate2D)endPoint{

    AMapNaviPoint * startP = [AMapNaviPoint locationWithLatitude:startPoint.latitude longitude:startPoint.longitude];
    AMapNaviPoint * endP = [AMapNaviPoint locationWithLatitude:endPoint.latitude longitude:endPoint.longitude];
    self.driverManager = [[AMapNaviDriveManager alloc] init];
    [self.driverManager setDelegate:self];
    [self.driverManager calculateDriveRouteWithStartPoints:@[startP] endPoints:@[endP] wayPoints:nil drivingStrategy:AMapNaviDrivingStrategyFastestTime];
  

}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    //算路成功后显示路径
    if ([driveManager.naviRoutes count] <= 0)
    {
        return;
    }
    for (NSNumber *aRouteID in [driveManager.naviRoutes allKeys])
    {
    
      AMapNaviRoute *aRoute = [[driveManager naviRoutes] objectForKey:aRouteID];
        self.result(aRoute);
        return;
    
    }
  
}
#pragma mark - AMapNaviDriveManager Delegate

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error
{
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}



- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error
{
    NSLog(@"onCalculateRouteFailure:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode
{
    NSLog(@"didStartNavi");
}

- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"needRecalculateRouteForYaw");
}

- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"needRecalculateRouteForTrafficJam");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex
{
    NSLog(@"onArrivedWayPoint:%d", wayPointIndex);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onArrivedDestination");
}
- (void)getCalculateRountDriveInfo:(void (^)(AMapNaviRoute *))callBack{

    self.result = [callBack copy];

}
@end
