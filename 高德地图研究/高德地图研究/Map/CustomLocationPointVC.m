//
//  CustomLocationPointVC.m
//  高德地图研究
//
//  Created by fly on 2017/7/18.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "CustomLocationPointVC.h"

@interface CustomLocationPointVC ()
{
    MAMapView *_mapView;
}

@end

@implementation CustomLocationPointVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 展示室内地图
    _mapView.showsIndoorMap = YES;

    [self customLocationPoint];
    
    [self changeMapLayer];
    
    [self isShowTraffic];
}
/*!
 *  切换地图图层
 */
- (void)changeMapLayer {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 64, 70, 30);
    [btn setTitle:@"切换图层" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(changMapeLayerAction:) forControlEvents:UIControlEventTouchUpInside];
}

/*!
 *  是否显示路况图层
 */
- (void)isShowTraffic {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 64 + 40, 60, 30);
    [btn setTitle:@"路况" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(isShowTrafficAction:) forControlEvents:UIControlEventTouchUpInside];
}
/*!
 *  自定义小蓝点
 */
- (void)customLocationPoint {
    // 用户位置显示样式
    MAUserLocationRepresentation *re = [MAUserLocationRepresentation  new];
    re.showsAccuracyRing = YES; // 精度圈是否显示
    re.showsHeadingIndicator = YES; // 显示方向指示
    re.fillColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.9 alpha:0.3]; // 精度圈填充颜色
//    re.strokeColor = [UIColor redColor]; // 精度圈边线颜色
    re.lineWidth = 80; // 精度圈边线宽度

    // 设置的是小蓝点的
    re.enablePulseAnnimation = YES; ///内部蓝色圆点是否使用律动效果, 默认YES
    re.locationDotBgColor = [UIColor orangeColor]; // 定位点背景颜色
    re.locationDotFillColor = [UIColor purpleColor]; // 定位点颜色
    re.image = [UIImage imageNamed:@"location_map"];
    [_mapView updateUserLocationRepresentation:re];

}

#pragma mark ---actions---
- (void)changMapeLayerAction:(UIButton *)sender {
//    MAMapTypeStandard = 0,  ///< 普通地图
//    MAMapTypeSatellite,     ///< 卫星地图
//    MAMapTypeStandardNight, ///< 夜间视图
//    MAMapTypeNavi,          ///< 导航视图
//    MAMapTypeBus            ///< 公交视图
    static int a = 0;
    [_mapView setMapType:a];
    a++;
    if (a >= 5) {
        a = 0;
    }
}

- (void)isShowTrafficAction:(UIButton *)sender {
    
    _mapView.showTraffic = _mapView.showTraffic?NO:YES;
}
@end



















