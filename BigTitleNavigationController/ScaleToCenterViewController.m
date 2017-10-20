//
//  ScaleToCenterViewController.m
//  BigTitleNavigationController
//
//  Created by admin on 2017/6/7.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScaleToCenterViewController.h"
#import "UIView+SLFrame.h"

@interface ScaleToCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ScaleToCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.enableScrollToBottomFill=YES;

    // Do any additional setup after loading the view.
    self.title=@"放大缩小居中";

    self.navigationBar.scrollType=SL_NavigationBarScrollType_ScaleToCenter;
    [self.navigationBar.btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [self.navigationBar.btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationBar.btnBack.titleLabel.font=[UIFont systemFontOfSize:15];
    self.navigationBar.btnBack.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    self.navigationBar.btnBack.width=60;
    
    UITableView *table=[[UITableView alloc] initWithFrame:self.baseViewBounds style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
    UIButton *view=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    view.backgroundColor=[UIColor yellowColor];
    view.center=self.view.center;
    view.sl_enableSuspension=YES;
    [view addTarget:self action:@selector(viewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];

}

-(void)viewClick{
    ScaleToCenterViewController *stv=[[ScaleToCenterViewController alloc] init];
    stv.enableNavigtionPan=YES;
    [self.navigationController pushViewController:stv animated:YES];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"sssss"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sssss"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%zi",indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self sl_optimzeScroll:scrollView];
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
