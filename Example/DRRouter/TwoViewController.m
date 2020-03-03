//
//  TwoViewController.m
//  DRRouter_Example
//
//  Created by 李风 on 2020/3/3.
//  Copyright © 2020 3257468284@qq.com. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *textId;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"text = %@, textId = %@",self.text,self.textId);
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
