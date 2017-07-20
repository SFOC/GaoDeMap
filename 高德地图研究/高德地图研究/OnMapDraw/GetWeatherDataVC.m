//
//  GetWeatherDataVC.m
//  高德地图研究
//  获取天气数据
//  Created by fly on 2017/7/20.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "GetWeatherDataVC.h"

@interface GetWeatherDataVC ()<AMapSearchDelegate>
@property (nonatomic, strong) AMapSearchAPI *search; // 搜索
@end

@implementation GetWeatherDataVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initWeather];
}

/**
 *  构造天气
 */
- (void)initWeather {
    self.search = [AMapSearchAPI new];
    self.search.delegate = self;
    
    // 设置天气查询参数
    AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc]init];
    request.city = @"西安市";
    request.type = AMapWeatherTypeLive; // 实时天气
    
    // 发起天气查询参数
    [self.search AMapWeatherSearch:request];
}

#pragma mark ---AMapSearchDelegate---
// 请求成功
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response {
    /**
     *  当查询成功时，会进到 onWeatherSearchDone 回调函数，通过回调函数，可获取查询城市实时的以及未来3天的天气情况。
     说明:
     1）通过 response.lives 获取城市对应实时天气数据信息，实时天气详细信息参考 AMapLocalWeatherLive 类。
     2）通过 response.forecasts 获取城市对应预报天气数据信息，预报天气详细信息参考 AMapLocalWeatherForecast 类。
     3）可查询未来3天的预报天气，通过 AMapLocalWeatherForecast.casts 获取预报天气列表
     */
    
    ///实时天气数据信息 AMapLocalWeatherLive 数组，仅在请求实时天气时有返回。
//    @property (nonatomic, strong) NSArray<AMapLocalWeatherLive *> *lives;
//    ///预报天气数据信息 AMapLocalWeatherForecast 数组，仅在请求预报天气时有返回
//    @property (nonatomic, strong) NSArray<AMapLocalWeatherForecast *> *forecasts;
    
    /*
    @interface AMapLocalWeatherLive : AMapSearchObject
    ///区域编码
    @property (nonatomic, copy) NSString *adcode;
    ///省份名
    @property (nonatomic, copy) NSString *province;
    ///城市名
    @property (nonatomic, copy) NSString *city;
    ///天气现象
    @property (nonatomic, copy) NSString *weather;
    ///实时温度
    @property (nonatomic, copy) NSString *temperature;
    ///风向
    @property (nonatomic, copy) NSString *windDirection;
    ///风力，单位：级
    @property (nonatomic, copy) NSString *windPower;
    ///空气湿度
    @property (nonatomic, copy) NSString *humidity;
    ///数据发布时间
    @property (nonatomic, copy) NSString *reportTime;
     */
    
    // 你设置城市的当前天气信息
    AMapLocalWeatherLive *locationWeatherLive = response.lives[0];
    NSLog(@"当前天气信息为==城市：%@,天气现象：%@, 温度：%@,发布时间：%@",locationWeatherLive.city,locationWeatherLive.weather,locationWeatherLive.temperature,locationWeatherLive.reportTime);
}

// 请求失败
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"天气请求失败");
}
@end













