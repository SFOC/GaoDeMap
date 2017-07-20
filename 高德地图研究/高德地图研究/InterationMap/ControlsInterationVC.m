//
//  ControlsInterationVC.m
//  高德地图研究
//  控件交互
//  Created by fly on 2017/7/19.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "ControlsInterationVC.h"

@interface ControlsInterationVC ()

@end

@implementation ControlsInterationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initControlInteration];
}

/*!
 *  控件交互初始化
 */
- (void)initControlInteration {
    
    // 地图logo不能移除，但是能调整位置和大小
    self.mapView.logoCenter = self.view.center;
    
    // 指南针控件默认在右上角显示  能调整位置和大小
    self.mapView.showsCompass = YES;
    self.mapView.compassOrigin = CGPointMake(100, 200);
    
    // 比例尺控件
    self.mapView.showsScale = YES;
    self.mapView.scaleOrigin= CGPointMake(0, 22);  //设置比例尺位置
}

@end






















