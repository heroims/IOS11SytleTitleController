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
#define IS_IPhoneX (ScreenHeigth==812)

@interface SL_BaseViewController ()<SL_UIViewControllerScrollBackgroundDelegate>{
    NSString *_startTime;
    
    BOOL _isOptimzeScroll;
    float _optimzeOldY;
    NSInteger _scrollCount;
    
    CGPoint _beginPanScrollPoint;
    CGPoint _beginPanScrollContentOffset;
    CGPoint _beginPanOptimScrollContentOffset;
    
    //iphoneX viewWillDisappear神奇的篡改scrollview.contentOffset即使设置contentInsetAdjustmentBehavior也不起作用，暂时未发现解决方法
    CGPoint _iPoneXDisappearContentOffset;
    BOOL _willAppear;
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
    [_navigationBar.btnBack addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navigationBar];
    
    self.sl_scrollBackgroundContentSize=CGSizeMake(self.view.width, self.view.height+self.navigationBar.height-self.navigationBar.btnBack.bottom-(IS_IPhoneX?ScreenStatusBottom-10:0));

    _scrollCount=0;
    
    [[(SLBackGroundView*)self.view bgScroll].panGestureRecognizer addTarget:self action:@selector(scrollPanOptim:)];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _willAppear=YES;
    _iPoneXDisappearContentOffset=[(SLBackGroundView*)self.view bgScroll].contentOffset;
}

-(void)viewDidDisappear:(BOOL)animated{
    [(SLBackGroundView*)self.view bgScroll].contentOffset=_iPoneXDisappearContentOffset;
    _willAppear=NO;
}

-(void)setDisableBottomFill:(BOOL)disableBottomFill{
    _disableBottomFill=disableBottomFill;
    if (!(_disableBottomFill&&IS_IPhoneX)) {
        CGRect tmpFrame = self.view.frame;
        tmpFrame.size.height=ScreenHeigth-33;
        [(SLBackGroundView*)self.view bgScroll].frame=tmpFrame;
    }
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
        return CGRectMake(0, 0, self.view.width, (self.sl_enableScrollBackground?self.sl_scrollBackgroundContentSize.height:self.view.height)-(([self.tabBarController.viewControllers containsObject:self.navigationController]&&[self.navigationController.viewControllers.firstObject isEqual:self])?self.tabBarController.tabBar.height:0)+((IS_IPhoneX&&_enableScrollToBottomFill)?33:0));
    }
    
    
    return CGRectMake(0, self.navigationBar.bottom, self.view.width, (self.sl_enableScrollBackground?self.sl_scrollBackgroundContentSize.height:self.view.height)-self.navigationBar.bottom-(([self.tabBarController.viewControllers containsObject:self.navigationController]&&[self.navigationController.viewControllers.firstObject isEqual:self])?self.tabBarController.tabBar.height:0)+((IS_IPhoneX&&_enableScrollToBottomFill)?33:0));
}

#pragma mark -
-(void)scrollPanOptim:(UIPanGestureRecognizer*)panGesture{
    CGPoint scrollPoint=[panGesture locationInView:self.view];
    if (panGesture.state==UIGestureRecognizerStateBegan) {
        _beginPanScrollPoint=scrollPoint;
        _beginPanScrollContentOffset=[(UIScrollView*)panGesture.view contentOffset];
        _beginPanOptimScrollContentOffset=_optimScrollView.contentOffset;
    }
    if (panGesture.state==UIGestureRecognizerStateChanged) {
        CGFloat changeY=scrollPoint.y-_beginPanScrollPoint.y;
        CGFloat tmpContentOffset=_beginPanScrollContentOffset.y-changeY;
        if (tmpContentOffset<=0) {
            if (_optimScrollView) {
                CGPoint tmpPoint=_beginPanOptimScrollContentOffset;
                tmpPoint.y-=(changeY/2.);
                [_optimScrollView setContentOffset:tmpPoint animated:NO];
            }
        }
    }
    if (panGesture.state==UIGestureRecognizerStateEnded||panGesture.state==UIGestureRecognizerStateCancelled) {
        if (_optimScrollView.contentOffset.y<0) {
            [_optimScrollView setContentOffset:CGPointZero animated:YES];
        }
    }
}

#pragma mark - SL_UIViewControllerScrollBackgroundProtocol
-(void)sl_optimzeScroll:(UIScrollView*)scrollView{
    _optimScrollView=scrollView;
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
    if (_willAppear) {
        [(SLBackGroundView*)self.view bgScroll].bounds=CGRectMake(_iPoneXDisappearContentOffset.x, _iPoneXDisappearContentOffset.y, [(SLBackGroundView*)self.view bgScroll].bounds.size.width, [(SLBackGroundView*)self.view bgScroll].bounds.size.height);
    }

    //ios11 开始出现的诡异现象，首次进入scroll乱滚两次
    if (_scrollCount<2&&scrollView.contentOffset.y<0) {
        return;
    }
    _scrollCount++;
    
    CGFloat scale=scrollView.contentOffset.y/(NavigationBarNormalHeight-self.navigationBar.btnBack.bottom);
    
    if (_isOptimzeScroll) {
        [self.navigationBar navigationBarAnimationWithScale:scale];
    }
    if ([scrollView isEqual:[(SLBackGroundView*)self.view bgScroll]]) {
        [self.navigationBar navigationBarAnimationWithScale:scale];
    }
}


@end
