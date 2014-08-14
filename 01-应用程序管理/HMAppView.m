//
//  HMAppView.m
//  01-应用程序管理
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMAppView.h"
#import "HMAppInfo.h"

@interface HMAppView()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation HMAppView

+ (instancetype)appView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMAppView" owner:nil options:nil] lastObject];
}

+ (instancetype)appViewWithAppInfo:(HMAppInfo *)appInfo
{
    // 1. 实例化一个视图
    HMAppView *view = [self appView];
    
    // 2. 设置视图的显示
    view.appInfo = appInfo;
    
    // 3. 返回视图
    return view;
}

/**
 利用setter方法设置视图的界面显示
 */
- (void)setAppInfo:(HMAppInfo *)appInfo
{
    _appInfo = appInfo;
    
    self.label.text = appInfo.name;
    self.iconView.image = appInfo.image;
}

/** 按钮监听方法 */
- (IBAction)click:(UIButton *)button
{
//    NSLog(@"%s %d", __func__, button.tag);
//    
//    // 取出appInfo
//    HMAppInfo *appInfo = self.appList[button.tag];
    
    // 添加一个UILabel到界面上
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 400, 160, 40)];
    // 数值是0表示黑色，1表示纯白
    // alpha表示透明度
    label.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    label.text = self.appInfo.name;
    label.textAlignment = NSTextAlignmentCenter;
    
    // self.superview就是视图控制器中的self.view
    [self.superview addSubview:label];
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
            
            [label removeFromSuperview];
        }];
    }];
}

@end
