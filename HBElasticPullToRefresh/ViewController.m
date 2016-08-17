//
//  ViewController.m
//  HBElasticPullToRefresh
//
//  Created by Beans on 16/8/16.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

#import "ViewController.h"
#import "HBElasticView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    HBElasticView *elasticView = [[HBElasticView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    elasticView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:elasticView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
