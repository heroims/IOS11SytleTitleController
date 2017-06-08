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

@property (nonatomic,assign) BOOL enableNavigtionPan;//仅控制多层嵌套UIScroll时是否响应

@end
