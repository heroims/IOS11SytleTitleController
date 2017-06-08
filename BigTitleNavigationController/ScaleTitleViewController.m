//
//  ScaleTitleViewController.m
//  BigTitleNavigationController
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScaleTitleViewController.h"
#import "UIView+SLFrame.h"

@interface ScaleTitleViewController ()

@end

@implementation ScaleTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title=@"放大缩小";
    
    self.navigationBar.scrollType=SL_NavigationBarScrollType_Scale;
    
    self.navigationBar.titleMargin=self.navigationBar.btnBack.right;
    
    
    for (NSInteger i=0; i<6; i++) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, self.navigationBar.bottom+i*80, 60, 60)];
        view.backgroundColor=[UIColor yellowColor];
        view.centerX=self.view.centerX;
        [self.view addSubview:view];
    }
    // Do any additional setup after loading the view.
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
