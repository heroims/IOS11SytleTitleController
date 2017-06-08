//
//  SL_BaseViewController.m
//  BigTitleNavigationController
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SL_BaseViewController.h"
#import "UIView+SLFrame.h"

#define CurrenVersion [[[UIDevice currentDevice] systemVersion] floatValue]

@interface SL_BaseViewController ()<SL_UIViewControllerScrollBackgroundDelegate>{
    NSString *_startTime;
    
    BOOL _isOptimzeScroll;
    float _optimzeOldY;

}

@end

@implementation SL_BaseViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [UIView setAnimationsEnabled:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.navigationBar.hidden==NO) {
        self.navigationController.navigationBar.hidden = YES;
    }
    if (CurrenVersion >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.clipsToBounds = YES;
    
    self.sl_enableScrollBackground=YES;
    self.sl_scrollBackgroundDelgate=self;
    self.sl_scrollBackgroundBounces=NO;
    
    // Do any additional setup after loading the view.
    
    _navigationBar = [[SL_NavigationBar alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, NavigationBarNormalHeight)];
    [_navigationBar.btnBack setImage:[UIImage imageNamed:@"lk_back_black"] forState:UIControlStateNormal];
    [_navigationBar.btnBack addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navigationBar];

    self.sl_scrollBackgroundContentSize=CGSizeMake(self.view.width, self.view.height+self.navigationBar.height-self.navigationBar.btnBack.bottom);

}

-(void)setTitle:(NSString *)title{
    [self.navigationBar setTitle:title];
}

-(void)goBackClick{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGRect)baseViewBounds{
    if (self.navigationBar.hidden||self.navigationBar.height<=0) {
        return CGRectMake(0, 0, self.view.width, (self.sl_enableScrollBackground?self.sl_scrollBackgroundContentSize.height:self.view.height)-(([self.tabBarController.viewControllers containsObject:self.navigationController]&&[self.navigationController.viewControllers.firstObject isEqual:self])?self.tabBarController.tabBar.height:0));
    }
    
    
    return CGRectMake(0, self.navigationBar.bottom, self.view.width, (self.sl_enableScrollBackground?self.sl_scrollBackgroundContentSize.height:self.view.height)-self.navigationBar.bottom-(([self.tabBarController.viewControllers containsObject:self.navigationController]&&[self.navigationController.viewControllers.firstObject isEqual:self])?self.tabBarController.tabBar.height:0));
}

#pragma mark - SL_UIViewControllerScrollBackgroundProtocol
-(void)sl_optimzeScroll:(UIScrollView*)scrollView{
    if (_enableNavigtionPan&&[(SLBackGroundView*)self.view bgScroll].dragging) {
        [scrollView setContentOffset:scrollView.contentOffset animated:NO];
        return;
    }
    
    if (scrollView.contentSize.height>scrollView.height&&scrollView.contentSize.height<(scrollView.height+(NavigationBarNormalHeight-self.navigationBar.btnBack.bottom))) {
        scrollView.contentSize=CGSizeMake(scrollView.contentSize.width, (scrollView.height+(NavigationBarNormalHeight-self.navigationBar.btnBack.bottom)));
    }
    
    _isOptimzeScroll=YES;
    if (!_enableNavigtionPan) {
        [(SLBackGroundView*)self.view bgScroll].scrollEnabled=NO;
    }
    
    float newY = 0;
    BOOL isUp=NO;
    
    newY = scrollView.contentOffset.y;
    
    float diffOffsetY=newY-scrollView.sl_lastScrollContentOffset.y;
    
    if (newY != scrollView.sl_lastScrollContentOffset.y) {
        if (newY > scrollView.sl_lastScrollContentOffset.y) {
//            NSLog(@"Down");//✋↑
            isUp=NO;
        } else if (newY < scrollView.sl_lastScrollContentOffset.y) {
//            NSLog(@"Up");//✋↓
            isUp=YES;
        }
        
        scrollView.sl_lastScrollContentOffset=scrollView.contentOffset;
    }
    
    
    CGPoint tmpContentOffset=[(SLBackGroundView*)self.view bgScroll].contentOffset;
    
    if (isUp) {
        if (tmpContentOffset.y<=(NavigationBarNormalHeight-(44.+ScreenStatusBottom))&&scrollView.contentOffset.y<(NavigationBarNormalHeight-(44.+ScreenStatusBottom))) {
            tmpContentOffset.y+=diffOffsetY;
        }
    }
    if (!isUp) {
        if (tmpContentOffset.y<=(NavigationBarNormalHeight-(44.+ScreenStatusBottom))&&tmpContentOffset.y>=0&&scrollView.contentOffset.y>0) {
            tmpContentOffset.y+=diffOffsetY;
        }
    }
    
    tmpContentOffset.y=(tmpContentOffset.y>(NavigationBarNormalHeight-(44.+ScreenStatusBottom)))?(NavigationBarNormalHeight-(44.+ScreenStatusBottom)):tmpContentOffset.y;
    tmpContentOffset.y=(tmpContentOffset.y<0)?(0):tmpContentOffset.y;
    tmpContentOffset.x=0;
    
    [(SLBackGroundView*)self.view bgScroll].contentOffset=tmpContentOffset;
    
}

#pragma mark - SL_UIViewControllerScrollBackgroundDelegate
-(void)sl_scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scale=scrollView.contentOffset.y/(NavigationBarNormalHeight-self.navigationBar.btnBack.bottom);
    
    if (_isOptimzeScroll) {
        [self.navigationBar navigationBarAnimationWithScale:scale];
    }
    if ([scrollView isEqual:[(SLBackGroundView*)self.view bgScroll]]) {
        if (scrollView.contentOffset.y<=(NavigationBarNormalHeight-(44.+ScreenStatusBottom))&&scrollView.contentOffset.y>=0) {
            [self.navigationBar navigationBarAnimationWithScale:scale];
        }
    }
}


@end
