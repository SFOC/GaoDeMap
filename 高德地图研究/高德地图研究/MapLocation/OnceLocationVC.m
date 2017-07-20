//
//  OnceLocationVC.m
//  高德地图研究
//  单次定位
//  Created by fly on 2017/7/18.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "OnceLocationVC.h"

@interface OnceLocationVC ()
@property (nonatomic, strong) AMapLocationManager *locationManager; // 定位管理
@end

@implementation OnceLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    [self initLoaction];
}

/*!
 初始化定位
 
 由于苹果系统的首次定位结果为粗定位，其可能无法满足需要高精度定位的场景。
 所以，高德提供了 kCLLocationAccuracyBest 参数，设置该参数可以获取到精度在10m左右的定位结果，但是相应的需要付出比较长的时间（10s左右），越高的精度需要持续定位时间越长。
 */
- (void)initLoaction {
    self.locationManager = [[AMapLocationManager alloc]init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    // 设置定位超时默认10秒
    self.locationManager.locationTimeout = 7;
    // 逆地理编码请求超时 默认5秒
    self.locationManager.reGeocodeTimeout = 5;
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            NSLog(@"error=%@",error);
            return ;
        }
        
        if (regeocode) {
            NSLog(@"regeocode=%@",regeocode);
        }
    }];
}



@end
