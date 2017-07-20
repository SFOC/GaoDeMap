//
//  MapScreenshots.m
//  高德地图研究
//  地图截屏
//  Created by fly on 2017/7/19.
//  Copyright © 2017年 flyfly. All rights reserved.
//

#import "MapScreenshots.h"

@interface MapScreenshots ()

@end

@implementation MapScreenshots

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self screenShot];
}

/*!
 *  地图截屏
 
 iOS 地图 SDK 支持对选定的屏幕地图区域(CGRect)进行截屏，截取的内容包括：地图、地图覆盖物、弹出气泡。
 说明：地图截屏功能依赖于地图显示，即：只有内容先显示在地图上，才能进行截屏。
 */
- (void)screenShot {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 64, 70, 30);
    [btn setTitle:@"截屏" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(screenShotAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ---截屏---
- (void)screenShotAction:(UIButton *)sender {
    
    __block UIImage *screenshotImage = nil;
    __block NSInteger resState = 0;
    [self.mapView takeSnapshotInRect:CGRectMake(0, 64, KWidth, KHeight - 64) withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
        screenshotImage = resultImage;
        resState = state; // state表示地图此时是否完整，0-不完整，1-完整
        if (state == 0) {
            NSLog(@"截屏完整");
        }else {
            NSLog(@"截屏不完整");
        }
        [self displayScreenshotImage:resultImage];
    }];
}

// 显示截屏后的照片
- (void)displayScreenshotImage:(UIImage *)img {
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, KWidth, KHeight - 64)];
    [self.view addSubview:imgView];
    if (img) {
        imgView.image = img;
    }
    NSLog(@"显示截屏");
}

@end











