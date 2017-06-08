//
//  LK_NavigationBar.h
//  BigTitleNavigationController
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenHeigth [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenStatusBottom  ([UIApplication sharedApplication].statusBarFrame.origin.y + [UIApplication sharedApplication].statusBarFrame.size.height)

#define NavigationBarNormalHeight (100.0+ScreenStatusBottom)

typedef enum SL_NavigationBarScrollType:NSInteger{
    SL_NavigationBarScrollType_Fade=0,//淡入淡出
    SL_NavigationBarScrollType_Scale,//放大缩小
    SL_NavigationBarScrollType_ScaleToCenter,//放大缩小并居中
    SL_NavigationBarScrollType_CenterScale//放大缩小并居中

}SL_NavigationBarScrollType;

@interface SL_NavigationBar : UIView

@property (nonatomic,strong)UILabel  * lblSmallTitle;
@property (nonatomic,strong)UILabel  * lblTitle;
@property (nonatomic,strong)UIButton * btnBack;
@property (nonatomic,strong)UIView   * lineView;

@property (nonatomic,assign)CGFloat lblTitleFontSize;
@property (nonatomic,assign)CGFloat lblTitleSmallFontSize;

@property (nonatomic,assign)CGFloat lineMargin;

@property (nonatomic,assign)CGFloat titleMargin;

@property (nonatomic,strong)NSString *title;

@property (nonatomic,assign)SL_NavigationBarScrollType scrollType;

-(void)navigationBarAnimationWithScale:(CGFloat)scale;

@end
