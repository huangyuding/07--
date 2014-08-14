//
//  HMViewController.m
//  01-应用程序管理
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMViewController.h"
#import "HMAppInfo.h"

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
        
        // 从XIB来加载自定义视图
        UIView *appView = [[[NSBundle mainBundle] loadNibNamed:@"HMAppView" owner:nil options:nil] lastObject];
        // 设置视图位置
        appView.frame = CGRectMake(x, y, kAppViewW, kAppViewH);
        
        [self.view addSubview:appView];
        
        // 实现视图内部细节
        HMAppInfo *appInfo = self.appList[i];
        
        // 1> UIImageView
        UIImageView *icon = appView.subviews[0];
        
        // 设置图像
        icon.image = appInfo.image;
        
        // 2> UILabel -> 应用程序名称
        UILabel *label = appView.subviews[1];
        
        // 设置应用程序名称
        label.text = appInfo.name;
        
        // 3> UIButton -> 下载按钮
        UIButton *button = appView.subviews[2];
        
        // 给按钮添加监听方法
        button.tag = i;
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}

/** 按钮监听方法 */
- (void)click:(UIButton *)button
{
    NSLog(@"%s %d", __func__, button.tag);
    
    // 取出appInfo
    HMAppInfo *appInfo = self.appList[button.tag];
    
    // 添加一个UILabel到界面上
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 400, 160, 40)];
    // 数值是0表示黑色，1表示纯白
    // alpha表示透明度
    label.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    label.text = appInfo.name;
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    // 动画效果
    // 收尾式动画，修改对象的属性，frame,bounds,alpha
    // 初始透明度，完全透明
    label.alpha = 0.0;
    
    // 禁用按钮
    button.enabled = NO;
    
    // 动画结束之后删除
    // ^ 表示是block，块代码，是一个预先准备好的代码块，可以当做参数传递，在需要的时候执行！
    // 块代码在OC中，使用的非常普遍！
    [UIView animateWithDuration:1.0f animations:^{
        NSLog(@"动画开始");
        // 要修改的动画属性
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            // 动画完成后，所做的操作
            NSLog(@"动画完成");
            
//            button.enabled = NO;
            
            [label removeFromSuperview];
        }];
    }];
    
    NSLog(@"-------");
    
    // 收尾式动画，不容易监听动画完成时间，而且不容易实现动画嵌套
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0f];
//    label.alpha = 1.0;
//    [UIView commitAnimations];
}

@end
