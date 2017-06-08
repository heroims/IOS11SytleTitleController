//
//  CustomBaseViewController.m
//  BigTitleNavigationController
//
//  Created by admin on 2017/6/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomBaseViewController.h"

@interface CustomBaseViewController ()

@end

@implementation CustomBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar.btnBack setImage:[UIImage imageNamed:@"lk_back_black"] forState:UIControlStateNormal];

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
