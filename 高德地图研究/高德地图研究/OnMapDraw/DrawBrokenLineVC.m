//
//  DrawBrokenLineVC.m
//  高德地图研究
//  绘制折线
//  Created by fly on 2017/7/20.
//  Copyright © 2017年 flyfly. All rights reserved.
//

/**
 *  折线类为 MAPolyline，由一组经纬度坐标组成，并以有序序列形式建立一系列的线段。iOS SDK支持在3D矢量地图上绘制带箭头或有纹理等样式的折线，同时可设置折线端点和连接点的类型，以满足各种绘制线的场景
 */
#import "DrawBrokenLineVC.h"

@interface DrawBrokenLineVC ()<MAMapViewDelegate>

@end

@implementation DrawBrokenLineVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView.delegate = self;
    [self initBrokeLine];
}

/*!
 *  构造折线
 */
- (void)initBrokeLine {
    
    // 构造折线数据对象  (34.218755, 108.882494)
    CLLocationCoordinate2D commonPolyLineCoords[4];
    commonPolyLineCoords[0].latitude = 34.218755;
    commonPolyLineCoords[0].longitude = 108.88243;
    
    commonPolyLineCoords[1].latitude = 34.232136;
    commonPolyLineCoords[1].longitude = 108.872346;
    
    commonPolyLineCoords[2].latitude = 34.172136;
    commonPolyLineCoords[2].longitude = 108.8424753;
    
    commonPolyLineCoords[3].latitude = 34.248755;
    commonPolyLineCoords[3].longitude = 108.85853;
    
    // 构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolyLineCoords count:4];
    // 在地图上添加折线对象
    [self.mapView addOverlay:commonPolyline];
}

#pragma mark ---MAMapViewDelegate---
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc]initWithPolyline:overlay];
        polylineRenderer.lineWidth = 8.f;
        polylineRenderer.strokeColor = [UIColor redColor];
        // 线的点类型
        polylineRenderer.lineJoinType = kMALineJoinRound;
        // 线头类型
        polylineRenderer.lineCapType = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}
@end















