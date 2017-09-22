//
//  FadeTitleViewController.m
//  BigTitleNavigationController
//
//  Created by Zhao Yiqi on 2017/6/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FadeTitleViewController.h"
#import "FadeTitleViewController.h"
#import "UIView+SLFrame.h"

@interface FadeTitleViewController ()

@end

@implementation FadeTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"淡入淡出";
    
    self.navigationBar.scrollType=SL_NavigationBarScrollType_Fade;
    [self.navigationBar.btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [self.navigationBar.btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationBar.btnBack.titleLabel.font=[UIFont systemFontOfSize:15];
    self.navigationBar.btnBack.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    self.navigationBar.btnBack.width=60;

    UIView *view=[[UIView alloc] initWithFrame:self.baseViewBounds];
    view.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
