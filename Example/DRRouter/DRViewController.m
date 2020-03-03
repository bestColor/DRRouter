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
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

}

- (void)click {
    [DRRouter router:@"present://to?text=abc&textId=13"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
