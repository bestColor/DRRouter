//
//  DRViewController.m
//  DRRouter
//
//  Created by 3257468284@qq.com on 03/03/2020.
//  Copyright (c) 2020 3257468284@qq.com. All rights reserved.
//

#import "DRViewController.h"
#import "DRRouter.h"

@interface DRViewController ()

@end

@implementation DRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 64);
    [button setTitle:@"send" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(testEg) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)testEg {
    [DRRouter registerHost:@{@"two":@"TwoViewController"}];
    UIViewController *vc = [DRRouter router:@"path://two?text=abc&textId=13"];
    [vc setValue:[UIImage imageNamed:@"LanchImagebg01"] forKey:@"aa"];
    [self presentViewController:vc animated:YES completion:nil];
    
    [DRRouter sendMessage:vc action:@"abc" param:nil];
    [DRRouter sendMessage:vc action:@"abc:" param:@"哈哈"];
    [DRRouter sendMessage:vc action:@"abc" param:@"嘿嘿"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
