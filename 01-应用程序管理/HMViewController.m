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
        // appList保存的是字典=>模型
//        _appList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil]];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil]];
        
        // 创建一个临时数组
        NSMutableArray *arraM = [NSMutableArray array];
        // 遍历数组，依次转换模型
        for (NSDictionary *dict in array) {
            HMAppInfo *appInfo = [[HMAppInfo alloc] init];
            appInfo.name = dict[@"name"];
            appInfo.icon = dict[@"icon"];
            
            [arraM addObject:appInfo];
        }
        
        // 将临时数组为属性赋值
        _appList = arraM;
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
        icon.image = [UIImage imageNamed:appInfo.icon];
        
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
    }
}

@end
