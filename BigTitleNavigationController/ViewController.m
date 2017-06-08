//
//  ViewController.m
//  BigTitleNavigationController
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SLFrame.h"
#import "ScaleTitleViewController.h"
#import "ScaleToCenterViewController.h"
#import "FadeTitleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.btnBack.hidden=YES;
    
    self.title=@"主程序";
        
    self.navigationBar.scrollType=SL_NavigationBarScrollType_CenterScale;
    
    UIButton *btn1=[[UIButton alloc] initWithFrame:CGRectMake(0, self.navigationBar.bottom, ScreenWidth, 60)];
    [btn1 setTitle:@"放大缩小模式" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.tag=1111;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2=[[UIButton alloc] initWithFrame:CGRectMake(0, btn1.bottom, ScreenWidth, 60)];
    [btn2 setTitle:@"放大缩小居中模式" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.tag=2222;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    UIButton *btn3=[[UIButton alloc] initWithFrame:CGRectMake(0, btn2.bottom, ScreenWidth, 60)];
    [btn3 setTitle:@"淡入淡出模式" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.tag=3333;
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)btnClick:(UIButton*)sender{
    switch (sender.tag) {
        case 1111:
        {
            ScaleTitleViewController *stv=[[ScaleTitleViewController alloc] init];
            [self.navigationController pushViewController:stv animated:YES];
        }
            break;
        case 2222:
        {
            ScaleToCenterViewController *stv=[[ScaleToCenterViewController alloc] init];
            [self.navigationController pushViewController:stv animated:YES];
        }
            break;
        case 3333:
        {
            FadeTitleViewController *stv=[[FadeTitleViewController alloc] init];
            [self.navigationController pushViewController:stv animated:YES];
        }
            break;

        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
