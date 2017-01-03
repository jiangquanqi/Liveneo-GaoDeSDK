//
//  GaoDeDriveNaviC.h
//  gaodeTEST
//
//  Created by cwwmac01 on 2016/12/5.
//  Copyright © 2016年 朗泰恒盛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
/// 此工具类是导航工具类 使用时采用push方法 需要传入目的地的高德坐标 如果起始地的坐标不赋值 就默认从当前所在位置开始导航 使用方法如下
//GaoDeDriveNaviC * page = [[GaoDeDriveNaviC alloc] init];
//page.endLocation = CLLocationCoordinate2DMake(39.990459, 116.471476);
//[self.navigationController pushViewController:page animated:YES];

@interface GaoDeDriveNaviC : UIViewController

@property (nonatomic,strong)MAMapView * mapView;
@property (nonatomic,strong)AMapSearchAPI * search;
@property (nonatomic,strong) AMapNaviDriveManager * driveManager;

@property (nonatomic,assign)CLLocationCoordinate2D startLocation; //开始位置的经纬度 如果此处不赋值默认从当前位置开始导航
@property (nonatomic,assign)CLLocationCoordinate2D endLocation; //终点位置的经纬度


@property (nonatomic,assign)BOOL hiddleMap;    //是否隐藏地图

@end
