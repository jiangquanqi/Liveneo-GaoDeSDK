//
//  GaoDeDriveNaviC.m
//  gaodeTEST
//
//  Created by cwwmac01 on 2016/12/5.
//  Copyright © 2016年 朗泰恒盛. All rights reserved.
//

#import "GaoDeDriveNaviC.h"
#import "SpeechSynthesizer.h"
#import "DriveNaviViewController.h"


@interface GaoDeDriveNaviC ()<MAMapViewDelegate,AMapNaviDriveManagerDelegate,DriveNaviViewControllerDelegate>
{
    AMapNaviPoint * _endPoint;
    AMapNaviPoint * _startPoint;
    MAUserLocation * _usetLocation;

}

@end

@implementation GaoDeDriveNaviC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    if (!self.hiddleMap) {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        [self.view addSubview:self.mapView];
    }

    
    self.driveManager = [[AMapNaviDriveManager alloc] init];
    [self.driveManager setDelegate:self];
    [self.driveManager setAllowsBackgroundLocationUpdates:YES];
    [self.driveManager setPausesLocationUpdatesAutomatically:NO];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    if (!self.hiddleMap) {
        [self.mapView setShowsUserLocation:YES];
    }
    
    
    _endPoint = [AMapNaviPoint locationWithLatitude:self.endLocation.latitude longitude:self.endLocation.longitude];
    if (_startPoint) {
        _startPoint = [AMapNaviPoint locationWithLatitude:self.startLocation.latitude longitude:self.startLocation.longitude];
        [self.driveManager calculateDriveRouteWithStartPoints:@[_startPoint] endPoints:@[_endPoint] wayPoints:nil drivingStrategy:AMapNaviDrivingStrategySingleDefault];
    }else{
        //如果没有设置开始位置就从当前位置开始导航
        [self voutePlanAction];
    
    }


}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBarHidden = YES;
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}



#pragma mark - MapView Delegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!_usetLocation)
    {
  
       
    }
    _usetLocation = userLocation;

}
- (void)voutePlanAction{


    [self.driveManager calculateDriveRouteWithEndPoints:@[_endPoint] wayPoints:nil drivingStrategy:AMapNaviDrivingStrategySingleDefault];


}
#pragma mark - DriveNaviView Delegate

- (void)driveNaviViewCloseButtonClicked
{
    //停止导航
    [self.driveManager stopNavi];
    
    //停止语音
    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
    
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - AMapNaviDriveManager Delegate

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error
{
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    DriveNaviViewController *driveVC = [[DriveNaviViewController alloc] init];
    [driveVC setDelegate:self];
    
    //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
    [self.driveManager addDataRepresentative:driveVC.driveView];
    
    [self.navigationController pushViewController:driveVC animated:NO];
    [self.driveManager startGPSNavi];
    //开始模拟导航
//    [self.driveManager startEmulatorNavi];
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
    
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onArrivedDestination");
}






@end
