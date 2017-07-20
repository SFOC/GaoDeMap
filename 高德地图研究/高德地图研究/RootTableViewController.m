//
//  RootTableViewController.m
//  高德地图研究
//
//  Created by fly on 2017/7/18.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()
@property (nonatomic, strong) NSMutableArray *allDataMArr;
@end

@implementation RootTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [self initData];
}

- (void)initData {
    NSArray *sectionValue1 = @[@"后台定位",@"单次定位",@"持续定位",@"地理围栏",@"位置区域判断"];
    NSArray *sectionVC1 = @[@"BackgroundLocationVC",@"OnceLocationVC",@"BackgroundLocationVC",@"GeographicalFenceVC",@"BackgroundLocationVC"];
    NSMutableDictionary *tempDic1 = [NSMutableDictionary new];
    [tempDic1 setObject:sectionValue1 forKey:@"value"];
    [tempDic1 setObject:sectionVC1 forKey:@"vc"];
    [self.allDataMArr addObject:tempDic1];
    
    NSArray *sectionValue2 = @[@"自定义定位蓝点",@"显示室内地图",@"切换地图图层",@"使用离线地图"];
    NSArray *sectionVC2 = @[@"CustomLocationPointVC",@"CustomLocationPointVC",@"CustomLocationPointVC",@"OfflineVC"];
    NSMutableDictionary *tempDic2 = [NSMutableDictionary new];
    [tempDic2 setObject:sectionValue2 forKey:@"value"];
    [tempDic2 setObject:sectionVC2 forKey:@"vc"];
    [self.allDataMArr addObject:tempDic2];
    
    NSArray *sectionValue3 = @[@"控件交互",@"手势交互",@"方法交互",@"地图截屏功能"];
    NSArray *sectionVC3 = @[@"ControlsInterationVC",@"GestureInterationVC",@"MethodInterationVC",@"MapScreenshots"];
    NSMutableDictionary *tempDic3 = [NSMutableDictionary new];
    [tempDic3 setObject:sectionValue3 forKey:@"value"];
    [tempDic3 setObject:sectionVC3 forKey:@"vc"];
    [self.allDataMArr addObject:tempDic3];
    
    
    NSArray *sectionValue4 = @[@"绘制点标记",@"绘制折线",@"绘制面",@"轨迹纠偏",@"点平滑移动",@"自定义地图",@"绘制海量点图层",@"天气信息"];
    NSArray *sectionVC4 = @[@"DrawPointVC",@"DrawBrokenLineVC",@"DrawPointVC",@"DrawPointVC",@"DrawPointVC",@"DrawPointVC",@"DrawPointVC",@"GetWeatherDataVC"];
    NSMutableDictionary *tempDic4 = [NSMutableDictionary new];
    [tempDic4 setObject:sectionValue4 forKey:@"value"];
    [tempDic4 setObject:sectionVC4 forKey:@"vc"];
    [self.allDataMArr addObject:tempDic4];

    //    DrawPointVC
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allDataMArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tempArr = self.allDataMArr[section][@"value"];
    return tempArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [UITableViewCell new];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *tempArr = self.allDataMArr[indexPath.section][@"value"];
    cell.textLabel.text = tempArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *tempArr = self.allDataMArr[indexPath.section][@"vc"];
    NSArray *tempValueArr = self.allDataMArr[indexPath.section][@"value"];
    Class VC = NSClassFromString(tempArr[indexPath.row]);
    UIViewController *vc = [VC new];
    vc.title = tempValueArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ---懒加载---
- (NSMutableArray *)allDataMArr {
    if (!_allDataMArr) {
        _allDataMArr = [NSMutableArray new];
    }
    return _allDataMArr;
}
@end
