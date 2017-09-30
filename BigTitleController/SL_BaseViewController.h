//
//  SL_BaseViewController.h
//  BigTitleNavigationController
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ScrollBackground.h"
#import "SL_NavigationBar.h"

@interface SL_BaseViewController : UIViewController<SL_UIViewControllerScrollBackgroundProtocol>

@property (nonatomic,assign) CGRect baseViewBounds;

@property (nonatomic,strong) SL_NavigationBar * navigationBar;

@property (nonatomic,assign) BOOL enableNavigtionPan;//非iPhoneX设备可用，禁用滚动系统会自动滚一下再appear的时候，仅控制多层嵌套UIScroll时是否响应

@property (nonatomic,assign) BOOL enableScrollToBottomFill;//是否允许iPhone X底部填充，影响baseViewBounds数值,使用baseViewBounds前调用

@property (nonatomic,assign) BOOL disableBottomFill;//是否允许填充iPhone X底部，设置立即生效

@property (nonatomic,assign) UIScrollView *optimScrollView;//iPhone X有嵌套ScrollView是通过传递此属性和实现sl_optimzeScroll实现滚动效果最大优化,刘海导致禁用滚动系统会自动滚一下

@end
