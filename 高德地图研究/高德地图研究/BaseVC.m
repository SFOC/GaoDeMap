//
//  BaseVC.m
//  高德地图研究
//
//  Created by fly on 2017/7/19.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, KWidth, KHeight - 64)];
    _mapView.zoomLevel = 19;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    // 设置小蓝点
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}



@end
