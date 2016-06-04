//
//  ViewController.m
//  liveThumbView
//
//  Created by zhn on 16/6/4.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "ViewController.h"
#import "liveThumbView.h"
@interface ViewController ()
@property (nonatomic,weak) liveThumbView * liveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    liveThumbView * tempView = [liveThumbView liveThumbViewWithImageArray:@[[UIImage imageNamed:@"live_like_0"],[UIImage imageNamed:@"live_like_1"],[UIImage imageNamed:@"live_like_2"],[UIImage imageNamed:@"live_like_3"]] frame:CGRectMake(100, 100, 200, 300) needTimer:YES];
    self.liveView = tempView;
    [self.view addSubview:tempView];
    
    UIGestureRecognizer * tempges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheView)];
    [self.view addGestureRecognizer:tempges];
}


- (void)tapTheView{
    [self.liveView addAnimatedThumbSubLayers];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
