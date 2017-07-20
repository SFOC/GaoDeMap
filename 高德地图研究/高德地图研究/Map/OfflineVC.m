//
//  OfflineVC.m
//  高德地图研究
//  使用离线地图
//  Created by fly on 2017/7/19.
//  Copyright © 2017年 flyfly. All rights reserved.
//

/**
 离线地图可满足在无网络环境下查看地图信息的需求，在设备本地有离线地图数据的情况下，SDK 会优先加载离线地图。
 离线数据项 MAOfflineItem 包含城市编码、城市名称、数据状态等离线地图数据包的基本信息，是离线数据省信息（MAOfflineProvince）和离线数据城市信息（MAOfflineCity）的基类。离线数据城市信息（MAOfflineCity）又派生出三个子类，分别是全国概要图（MAOfflineItemNationWide）、直辖市（MAOfflineItemMunicipality）和普通城市（MAOfflineItemCommonCity）。
 */
#import "OfflineVC.h"

@interface OfflineVC ()
{
    MAOfflineMap *_offlineMap;
    MAOfflineCity *_tempOfflineCity;
}
@end

@implementation OfflineVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
// 开始下载
- (IBAction)startDownload:(UIButton *)sender {
    
    _offlineMap = [MAOfflineMap sharedOfflineMap];
    _tempOfflineCity = nil;
    
    for (MAOfflineCity *obj in _offlineMap.cities) {
        
        if ([obj isKindOfClass:[MAOfflineCity class]] && [obj.name isEqualToString:@"西安市"]) {
            
            _tempOfflineCity = obj;
        }
    }
    
    
    // 下载
    [_offlineMap downloadItem:_tempOfflineCity shouldContinueWhenAppEntersBackground:YES downloadBlock:^(MAOfflineItem *downloadItem, MAOfflineMapDownloadStatus downloadStatus, id info) {
        
        NSLog(@"下载的Item=%@\n 下载的状态==%ld\n 下载的信息=%@",downloadItem,(long)downloadStatus,info);
        if (downloadStatus == 3) {
            NSLog(@"下载完成");
        }
    }];
}

// 暂停下载
- (IBAction)pauseDownload:(id)sender {
    [_offlineMap pauseItem:_tempOfflineCity];
}

// 停止所有下载
- (IBAction)cancelAllDownload:(id)sender {
    [_offlineMap cancelAll];
}

// 删除下载
- (IBAction)deleteOfflineMap:(id)sender {
//    [_offlineMap deleteItem:_tempOfflineCity];
    [_offlineMap clearDisk]; // 删除所有下载
    NSLog(@"删除成功");
}

// 检查更新
- (IBAction)checkNewsVersion:(id)sender {
    [_offlineMap checkNewestVersion:^(BOOL hasNewestVersion) {
        if (!hasNewestVersion)
        {
            return;
        }
        
        //更新处理
    }];
}


@end
























