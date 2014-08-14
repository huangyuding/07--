//
//  HMViewController.m
//  01-应用程序管理
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMViewController.h"
#import "HMAppInfo.h"
#import "HMAppView.h"

#define kAppViewW 80
#define kAppViewH 90
#define kColCount 3
#define kStartY   20

@interface HMViewController ()
/** 应用程序列表 */
@property (nonatomic, strong) NSArray *appList;
@end

@implementation HMViewController

- (NSArray *)appList
{
    if (_appList == nil) {
        _appList = [HMAppInfo appList];
    }
    return _appList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 搭建界面，九宫格
    // 320 - 3 * 80 = 80 / 4 = 20
    CGFloat marginX = (self.view.bounds.size.width - kColCount * kAppViewW) / (kColCount + 1);
    CGFloat marginY = 10;

    for (int i = 0; i < self.appList.count; i++) {
        // 行
        // 0, 1, 2 => 0
        // 3, 4, 5 => 1
        int row = i / kColCount;
        
        // 列
        // 0, 3, 6 => 0
        // 1, 4, 7 => 1
        // 2, 5, 8 => 2
        int col = i % kColCount;
        
        CGFloat x = marginX + col * (marginX + kAppViewW);
        CGFloat y = kStartY + marginY + row * (marginY + kAppViewH);
        
//        // 从XIB来加载自定义视图
//        HMAppView *appView = [[[NSBundle mainBundle] loadNibNamed:@"HMAppView" owner:nil options:nil] lastObject];
//        HMAppView *appView = [HMAppView appView];
        HMAppView *appView = [HMAppView appViewWithAppInfo:self.appList[i]];
        
        // 设置视图位置
        appView.frame = CGRectMake(x, y, kAppViewW, kAppViewH);
        
        [self.view addSubview:appView];
        
//        // 实现视图内部细节
//        appView.appInfo = self.appList[i];
    }
}

@end
