//
//  BackgroundLocationVC.m
//  高德地图研究
//  后台定位
//  Created by fly on 2017/7/18.
//  Copyright © 2017年 flyfly. All rights reserved.
//

/*
 iOS定位SDK提供后台持续定位的能力，可持久记录位置信息，适用于记轨迹录。
 */
#import "BackgroundLocationVC.h"

@interface BackgroundLocationVC ()<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager; // 定位管理
@end

@implementation BackgroundLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    [self initLoaction];
    
    //设置一个目标经纬度
    CLLocationCoordinate2D coodinate = CLLocationCoordinate2DMake(39.948691, 116.492479);
    //返回是否在大陆或以外地区，返回YES为大陆地区，NO为非大陆。
    BOOL flag= AMapLocationDataAvailableForCoordinate(coodinate);
    if (flag) {
        NSLog(@"在大陆");
    }else {
        NSLog(@"不在大陆");
    }
    
}

/*!
 初始化定位
 */
- (void)initLoaction {
    
    self.locationManager = [[AMapLocationManager alloc]init];
    self.locationManager.delegate = self;
    // 设置最小定位距离
    self.locationManager.distanceFilter = 10;
    // 后台定位是否返回逆地理信息，默认是NO
    self.locationManager.locatingWithReGeocode = YES;
    
    //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开始持续定位
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark ---AMapLocationManagerDelegate---
// 已经更新
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    if (reGeocode) { // 逆地理编码
        NSLog(@"reGeocode = %@",reGeocode);
    }
}
@end



















