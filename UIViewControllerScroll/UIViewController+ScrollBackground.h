//
//  UIViewController+ScrollBackground.h
//  xgoods
//
//  Created by admin on 2017/3/29.
//  Copyright © 2017年 Look. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SL_UIViewControllerScrollBackgroundProtocol <NSObject>

@required

/**
 优化滚动效果的实现方法
 
 嵌套使用各类可滚动控件时方便效果联动
 
 用法：在BaseController里实现该协议 完成对联动效果的定制
 
      在scrollViewDidScroll委托里调用此方法

 @param scrollView 子控件的UIScrollView
 */
-(void)sl_optimzeScroll:(UIScrollView*)scrollView;

@end

@protocol SL_UIViewControllerScrollBackgroundDelegate <NSObject>


/**
 SLBackGroundView的scrollViewDidScroll委托
 
 注：SLBackGroundView是Controller的self.view内的UIScrollView

 @param scrollView SLBackGroundView
 */
-(void)sl_scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface SLBackGroundScrollView : UIScrollView

@end

/**
 UIViewController 的self.view将被替换为SLBackGroundView方便实现self.view支持滚动
 */
@interface SLBackGroundView : UIView

@property(nonatomic,strong)SLBackGroundScrollView *bgScroll;
@property(nonatomic,weak)id<SL_UIViewControllerScrollBackgroundDelegate> scrollBackgroundDelgate;

@end

@interface UIScrollView (ScrollBackground)

/**
 用于记录最后一次滚动到的ContentOffset ，非自动化只是方便记录，需要手动实现，在sl_optimzeScroll即可，其他回调也行看个人需求而定
 */
@property(nonatomic,assign)CGPoint sl_lastScrollContentOffset;

@end

@interface UIView (ScrollBackground)

/**
 设置 view 悬浮模式，滚动不影响位置，相当于设置屏幕的frame为绝对位置
 */
@property(nonatomic,assign)BOOL sl_enableSuspension;

@end

@interface UIViewController (ScrollBackground)

/**
 设置是否允许self.view支持滚动  默认YES
 */
@property(nonatomic,assign)BOOL sl_enableScrollBackground;
/**
 设置是否允许self.view的ContentSize 
 */
@property(nonatomic,assign)CGSize sl_scrollBackgroundContentSize;
/**
 设置是否允许self.view的弹性 默认NO
 */
@property(nonatomic,assign)BOOL sl_scrollBackgroundBounces;

@property(nonatomic,weak)id<SL_UIViewControllerScrollBackgroundDelegate> sl_scrollBackgroundDelgate;

@end
