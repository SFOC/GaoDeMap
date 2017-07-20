//
//  DrawPointVC.m
//  高德地图研究
//  绘制点标记
//  Created by fly on 2017/7/19.
//  Copyright © 2017年 flyfly. All rights reserved.
//

/**
 标注可以精确表示用户需要展示的位置信息，高德地图SDK提供的标注功能允许用户自定义图标和信息窗，同时提供了标注的点击、拖动事件的回调
 */
#import "DrawPointVC.h"

@interface DrawPointVC ()<MAMapViewDelegate>

@end

@implementation DrawPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self addDefaultStylePoint];
}

/*!
 *  添加默认样式点标记
 */
- (void)addDefaultStylePoint {
    
    NSMutableArray *pointAnnotations = [NSMutableArray new];
    for (int i = 0; i < 7; i++) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
        // 当前定位的位置 (34.218755, 108.882494)
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(34.218759 + i*0.004, 108.882490 + i*0.005);
        pointAnnotation.title = [NSString stringWithFormat:@"峰苹国际%d",i];
        pointAnnotation.subtitle = [NSString stringWithFormat:@"南窑头西区商业区%d",i];
        [pointAnnotations addObject:pointAnnotation];
    }
    [self.mapView addAnnotations:pointAnnotations];
    
}

#pragma mark ---MAMapViewDelegate---
// 根据anntation生成对应的View
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *pointIndentifier = @"pointIndentifier";
        // MAPinAnnotationView提供大头针view
        // 先从缓存池中取出大头针
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:pointIndentifier];
        if (!annotationView) {
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointIndentifier];
        }
        annotationView.canShowCallout = YES; // 设置气泡可以弹出
        annotationView.animatesDrop = YES; // 设置标注使用下落动画
        annotationView.draggable = NO; // 设置标注不可以拖动
        annotationView.pinColor = MAPinAnnotationColorPurple; // 设置大头针颜色
        return annotationView;
    }
    return nil;
}
@end



















