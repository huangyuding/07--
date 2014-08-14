//
//  HMViewController.m
//  01-应用程序管理
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 搭建界面，九宫格
#define kAppViewW 80
#define kAppViewH 90
#define kColCount 3
#define kStartY   20
    
    // 320 - 3 * 80 = 80 / 4 = 20
    CGFloat marginX = (self.view.bounds.size.width - kColCount * kAppViewW) / (kColCount + 1);
    CGFloat marginY = 10;

    for (int i = 0; i < 12; i++) {
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
        
        UIView *appView = [[UIView alloc] initWithFrame:CGRectMake(x, y, kAppViewW, kAppViewH)];
        appView.backgroundColor = [UIColor redColor];
        [self.view addSubview:appView];
    }
    
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120, 20, 80, 90)];
//    view2.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view2];
//    
//    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(220, 20, 80, 90)];
//    view3.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view3];
//    
//    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(20, 120, 80, 90)];
//    view4.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view4];
//    
//    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 80, 90)];
//    view5.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view5];
//    
//    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(220, 120, 80, 90)];
//    view6.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view6];
}


@end
