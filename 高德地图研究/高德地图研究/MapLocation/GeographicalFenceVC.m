//
//  GeographicalFenceVC.m
//  高德地图研究
//  地理围栏
//  Created by fly on 2017/7/18.
//  Copyright © 2017年 flyfly. All rights reserved.
//

/*
 地理围栏没有最大个数限制，您可以无限制的创建围栏。但请您根据业务需求合理的创建围栏，控制围栏个数可以有效的保证程序执行效率。定位 SDK 提供根据高德POI、行政区划，自定义圆形、自定义多边形四种方式创建地理围栏。
 */
#import "GeographicalFenceVC.h"

@interface GeographicalFenceVC ()<AMapGeoFenceManagerDelegate>
@property (nonatomic, strong) AMapGeoFenceManager *geoFenceManager; // 地理围栏管理类
@end

@implementation GeographicalFenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    [self initGeographicalFence];
}

/*!
 *  初始化地理围栏
 */
- (void)initGeographicalFence {
    
    self.geoFenceManager = [[AMapGeoFenceManager alloc]init];
    // 设置代理
    self.geoFenceManager.delegate = self;
    //
//    AMapGeoFenceActiveActionNone     = 0,       ///< 不进行监听
//    AMapGeoFenceActiveActionInside   = 1 << 0,  ///< 在范围内
//    AMapGeoFenceActiveActionOutside  = 1 << 1,  ///< 在范围外
//    AMapGeoFenceActiveActionStayed   = 1 << 2,  ///< 停留(在范围内超过10分钟)
    // 设置需要进行通知的行为
    self.geoFenceManager.activeAction = AMapGeoFenceActiveActionInside | AMapGeoFenceActiveActionOutside | AMapGeoFenceActiveActionStayed;
    self.geoFenceManager.allowsBackgroundLocationUpdates = YES;  //允许后台定位

    // 1.创建高德POI地理围栏
    /**
     * @brief 根据要查询的关键字，类型，城市等信息，添加一个或者多个POI地理围栏
     * @param keyword 要查询的关键字，多个关键字用“|”分割，必填，keyword和type两者至少必选其一
     * @param type 要查询的POI类型，多个类型用“|”分割，必填，keyword和type两者至少必选其一，具体分类编码和规则详见： http://lbs.amap.com/api/webservice/guide/api/search/#text
     * @param city 要查询的城市
     * @param size 要查询的数据的条数，(0,25]，传入<=0的值为10，传入大于25的值为25，默认10
     * @param customID 用户自定义ID，可选，SDK原值返回
     */
//    [self.geoFenceManager addKeywordPOIRegionForMonitoringWithKeyword:@"北京大学" POIType:@"高等院校" city:@"北京" size:25 customID:@"beiJingDaXue"];

    
     // 2.添加周边围栏  34.2187549,108.8824937南窑头我住地方的经纬度
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(34.2187549,108.8824937);
    /**
     * @brief 根据要查询的点的经纬度，搜索半径等信息，添加一个或者多个POI围栏
     * @param locationPoint 点的经纬度坐标，必填
     * @param aroundRadius 查询半径，单位：米，(0,50000]，超出范围取3000，默认3000
     * @param keyword 要查询的关键字，多个关键字用“|”分割，可选
     * @param type 要查询的POI(感兴趣的点)类型，多个类型用“|”分割，可选
     * @param size 要查询的数据的条数，(0,25]，传入<=0的值为10，传入大于25的值为25，默认10
     * @param customID 用户自定义ID，可选，SDK原值返回
     */
    [self.geoFenceManager addAroundPOIRegionForMonitoringWithLocationPoint:coordinate aroundRadius:5000 keyword:@"肯德基" POIType:@"050301" size:10 customID:@"moEr"];
    
    // 3.创建行政区域围栏
    // 4.创建自定义圆形围栏
    // 5.创建自定义多边形围栏
    
    /*
     开始定位
     
     当围栏创建完毕，且围栏创建成功时会启动定位，这部分无需您来设置，SDK内部执行。 定位机制：通过“远离围栏时逐渐降低定位频率”来降低电量消耗，“离近围栏时逐渐提高定位频率”来保证有足够的定位精度从而完成围栏位置检测。
     需要注意，在iOS9及之后版本的系统中，如果您希望程序在后台持续检测围栏触发行为，需要保证manager的allowsBackgroundLocationUpdates为YES，设置为YES的时候必须保证 Background Modes 中的 Location updates 处于选中状态，否则会抛出异常
     
     */
}

#pragma mark ---AMapGeoFenceManagerDelegate---
/**
 * @brief 添加地理围栏完成后的回调，成功与失败都会调用
 * @param manager 地理围栏管理类
 * @param regions 成功添加的一个或多个地理围栏构成的数组
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 添加失败的错误信息
 */
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didAddRegionForMonitoringFinished:(NSArray <AMapGeoFenceRegion *> *)regions customID:(NSString *)customID error:(NSError *)error {
    
    if (error) {
        NSLog(@"创建地理围栏失败,%@",error);
        return;
    }
    NSLog(@"添加了地理围栏");
}


/**
 * @brief 地理围栏状态改变时回调，当围栏状态的值发生改变，定位失败都会调用
 * @param manager 地理围栏管理类
 * @param region 状态改变的地理围栏
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 错误信息，如定位相关的错误
 */
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didGeoFencesStatusChangedForRegion:(AMapGeoFenceRegion *)region customID:(NSString *)customID error:(NSError *)error {
    if (error) {
        NSLog(@"定位失败");
        return;
    }
    
    NSLog(@"地理围栏状态改变==%@",[region description]);
}

-(void)dealloc {
    [self.geoFenceManager removeAllGeoFenceRegions];
//    - (void)removeTheGeoFenceRegion:(AMapGeoFenceRegion *)region; //移除指定围栏
//    - (void)removeGeoFenceRegionsWithCustomID:(NSString *)customID; //移除指定customID的围栏
}
@end



























