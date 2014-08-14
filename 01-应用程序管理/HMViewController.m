//
//  HMViewController.m
//  01-应用程序管理
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMViewController.h"
#import "HMAppInfo.h"

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
#define kAppViewW 80
#define kAppViewH 90
#define kColCount 3
#define kStartY   20
    
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
        
        UIView *appView = [[UIView alloc] initWithFrame:CGRectMake(x, y, kAppViewW, kAppViewH)];
//        appView.backgroundColor = [UIColor redColor];
        [self.view addSubview:appView];
        
        // 实现视图内部细节
//        NSDictionary *dict = self.appList[i];
        HMAppInfo *appInfo = self.appList[i];
        
        // 1> UIImageView
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kAppViewW, 50)];
//        icon.backgroundColor = [UIColor greenColor];
        
        // 设置图像
//        icon.image = [UIImage imageNamed:dict[@"icon"]];
//        icon.image = [UIImage imageNamed:appInfo.icon];
        icon.image = appInfo.image;
        
        // 设置图像填充模式，等比例显示(CTRL+6)
        icon.contentMode = UIViewContentModeScaleAspectFit;
        
        [appView addSubview:icon];
        
        // 2> UILabel -> 应用程序名称
        // CGRectGetMaxY(frame) = frame.origin.y + frame.size.height
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame), kAppViewW, 20)];
//        lable.backgroundColor = [UIColor blueColor];
        
        // 设置应用程序名称
//        lable.text = dict[@"name"];
        lable.text = appInfo.name;
        
        // 设置字体
        lable.font = [UIFont systemFontOfSize:13.0];
        lable.textAlignment = NSTextAlignmentCenter;
        
        [appView addSubview:lable];
        
        // 3> UIButton -> 下载按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lable.frame), kAppViewW, 20)];
        button.backgroundColor = [UIColor yellowColor];
        
        // 背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        
        // 按钮都是有状态的，不同状态可以对应不同的标题
        [button setTitle:@"下载" forState:UIControlStateNormal];
        // *** 一定不要使用以下方法，修改按钮标题
//        button.titleLabel.text = @"aaa";
        
        // 修改字体（titleLabel是只读的）
        // readonly表示不允许修改titleLabel的指针，但是可以修改label的字体
        // 提示：按钮的字体是不区分状态的！
        button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        
        [appView addSubview:button];
        
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
