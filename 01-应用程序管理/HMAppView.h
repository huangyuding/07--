//
//  HMAppView.h
//  01-应用程序管理
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMAppInfo;

@interface HMAppView : UIView

//@property (weak, nonatomic) IBOutlet UIButton *button;

// 自定义视图中显示的数据来源是数据模型
// 使用模型设置自定义视图的显示
@property (nonatomic, strong) HMAppInfo *appInfo;

@end
