//
//  GestureInterationVC.m
//  高德地图研究
//  手势交互
//  Created by fly on 2017/7/19.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "GestureInterationVC.h"

@interface GestureInterationVC ()

@end

@implementation GestureInterationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self gestureUse];
}

/**
 *  MAMapView.zoomEnabled 此属性用于地图缩放手势的开启和关闭
    MAMapView.scrollEnabled  此属性用于地图滑动手势的开启和关闭
    MAMapView.rotateEnabled  此属性用于地图旋转手势的开启和关闭
    MAMapView.rotateCameraEnabled  此属性用于地图旋转旋转的开启和关闭
 */
/*!
 *  手势使用
 */
- (void)gestureUse {
    
    __weak typeof(self) weakSelf = self;
    // 设置当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
    static float latitude = 34.2187549;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude,108.8824937);
    // 一般用于定位自己当前的位置移动
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    latitude = latitude + 0.0001;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [weakSelf gestureUse];
    });
    
    
    // 旋转手势  旋转角度的范围是[0.f 360.f]，以逆时针为正向
    [self.mapView setRotationDegree:90.f animated:YES duration:0.5];
    
    // 倾斜手势
    self.mapView.rotateCameraEnabled= YES;    //NO表示禁用倾斜手势，YES表示开启
    // 倾斜角度范围为[0.f, 45.f]
    [self.mapView setCameraDegree:30.f animated:YES duration:0.5];
    
    
    // 指定屏幕中心点的手势操作
    //在对地图进行手势操作时（滑动手势除外），可以指定屏幕中心点后执行相应手势
//    MAMapStatus *status = [self.mapView getMapStatus];
//    status.screenAnchor = CGPointMake(0.3, 0.76);//地图左上为(0,0)点，右下为(1,1)点。
//    [self.mapView setMapStatus:status animated:YES];
}
@end















